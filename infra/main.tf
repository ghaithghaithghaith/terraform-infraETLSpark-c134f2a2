# â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
# Remote backend â€” state stored in S3, locking via DynamoDB
# (Provisioned by the bootstrap/ folder)
# â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
terraform {
  backend "s3" {
    bucket         = "tfstate-infraetlspark-nphvnhdq"
    key            = "infra/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "tflock-infraetlspark-nphvnhdq"
    encrypt        = true
  }
}

terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.6"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

resource "random_string" "suffix" {
  length  = 14
  special = false
  upper   = false
}

locals {
  random_suffix = random_string.suffix.result

  script_bucket_name = "${var.script_bucket_base_name}-${local.random_suffix}"
  output_bucket_name = "${var.output_bucket_base_name}-${local.random_suffix}"
  glue_job_name      = "${var.glue_job_base_name}-${local.random_suffix}"

  test_script_key = "scripts/${var.test_script_filename}"
  test_script_body = <<-EOT
print("Hello from TEST script")
EOT
}

resource "aws_s3_bucket" "script_bucket" {
  bucket        = local.script_bucket_name
  force_destroy = true

  tags = {
    Name = local.script_bucket_name
  }
}

resource "aws_s3_bucket_versioning" "script_bucket" {
  bucket = aws_s3_bucket.script_bucket.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "script_bucket" {
  bucket = aws_s3_bucket.script_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "script_bucket" {
  bucket                  = aws_s3_bucket.script_bucket.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket" "output_bucket" {
  bucket        = local.output_bucket_name
  force_destroy = true

  tags = {
    Name = local.output_bucket_name
  }
}

resource "aws_s3_bucket_versioning" "output_bucket" {
  bucket = aws_s3_bucket.output_bucket.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "output_bucket" {
  bucket = aws_s3_bucket.output_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "output_bucket" {
  bucket                  = aws_s3_bucket.output_bucket.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_object" "test_glue_script" {
  bucket       = aws_s3_bucket.script_bucket.id
  key          = local.test_script_key
  content      = local.test_script_body
  content_type = "text/x-python"
  etag         = md5(local.test_script_body)
}

data "aws_iam_policy_document" "glue_assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["glue.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "glue_job_role" {
  name               = "${var.glue_role_base_name}-${local.random_suffix}"
  assume_role_policy = data.aws_iam_policy_document.glue_assume_role.json

  tags = {
    Name = "${var.glue_role_base_name}-${local.random_suffix}"
  }
}

data "aws_iam_policy_document" "glue_job_policy" {
  statement {
    sid    = "AllowS3ReadWriteForGlueJob"
    effect = "Allow"

    actions = [
      "s3:GetObject",
      "s3:PutObject",
      "s3:DeleteObject",
      "s3:ListBucket",
      "s3:GetBucketLocation"
    ]

    resources = [
      aws_s3_bucket.script_bucket.arn,
      "${aws_s3_bucket.script_bucket.arn}/*",
      aws_s3_bucket.output_bucket.arn,
      "${aws_s3_bucket.output_bucket.arn}/*"
    ]
  }

  statement {
    sid    = "AllowGlueLogging"
    effect = "Allow"

    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]

    resources = ["*"]
  }
}

resource "aws_iam_role_policy" "glue_job_inline" {
  name   = "${var.glue_role_policy_base_name}-${local.random_suffix}"
  role   = aws_iam_role.glue_job_role.id
  policy = data.aws_iam_policy_document.glue_job_policy.json
}

resource "aws_glue_job" "etl_job" {
  name              = local.glue_job_name
  role_arn          = aws_iam_role.glue_job_role.arn
  glue_version      = "5.0"
  number_of_workers = 2
  worker_type       = "G.1X"
  max_retries       = 0
  timeout           = 60
  execution_class   = "STANDARD"

  command {
    name            = "glueetl"
    script_location = "s3://${aws_s3_bucket.script_bucket.bucket}/${aws_s3_object.test_glue_script.key}"
    python_version  = "3"
  }

  default_arguments = {
    "--job-language"                     = "python"
    "--enable-continuous-cloudwatch-log" = "true"
    "--enable-continuous-log-filter"     = "true"
    "--enable-metrics"                   = ""
    "--TempDir"                          = "s3://${aws_s3_bucket.output_bucket.bucket}/temp/"
    "--output_path"                      = "s3://${aws_s3_bucket.output_bucket.bucket}/output/"
  }

  execution_property {
    max_concurrent_runs = 1
  }

  depends_on = [
    aws_s3_object.test_glue_script,
    aws_iam_role_policy.glue_job_inline
  ]
}

resource "aws_vpc" "rds_vpc" {
  cidr_block           = var.rds_vpc_cidr_block
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "${var.rds_vpc_base_name}-${local.random_suffix}"
  }
}

resource "aws_subnet" "rds_subnet_a" {
  vpc_id            = aws_vpc.rds_vpc.id
  cidr_block        = var.rds_subnet_cidr_blocks[0]
  availability_zone = var.rds_subnet_availability_zones[0]

  tags = {
    Name = "${var.rds_subnet_base_name}-a-${local.random_suffix}"
  }
}

resource "aws_subnet" "rds_subnet_b" {
  vpc_id            = aws_vpc.rds_vpc.id
  cidr_block        = var.rds_subnet_cidr_blocks[1]
  availability_zone = var.rds_subnet_availability_zones[1]

  tags = {
    Name = "${var.rds_subnet_base_name}-b-${local.random_suffix}"
  }
}

resource "aws_security_group" "rds" {
  name        = "${var.rds_security_group_base_name}-${local.random_suffix}"
  description = "Security group for RDS"
  vpc_id      = aws_vpc.rds_vpc.id

  ingress {
    from_port   = var.rds_port
    to_port     = var.rds_port
    protocol    = "tcp"
    cidr_blocks = var.rds_allowed_cidr_blocks
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.rds_security_group_base_name}-${local.random_suffix}"
  }
}

resource "aws_db_subnet_group" "rds" {
  name       = "${var.rds_subnet_group_base_name}-${local.random_suffix}"
  subnet_ids = [aws_subnet.rds_subnet_a.id, aws_subnet.rds_subnet_b.id]

  tags = {
    Name = "${var.rds_subnet_group_base_name}-${local.random_suffix}"
  }
}

resource "aws_db_instance" "rds" {
  identifier                 = "${var.rds_identifier_base_name}-${local.random_suffix}"
  allocated_storage          = var.rds_allocated_storage
  engine                     = var.rds_engine
  engine_version             = var.rds_engine_version
  instance_class             = var.rds_instance_class
  db_name                    = var.rds_db_name
  username                   = var.rds_username
  password                   = var.rds_password
  port                       = var.rds_port
  db_subnet_group_name       = aws_db_subnet_group.rds.name
  vpc_security_group_ids     = [aws_security_group.rds.id]
  publicly_accessible        = false
  storage_encrypted          = true
  skip_final_snapshot        = true
  apply_immediately          = true
  auto_minor_version_upgrade = true
  backup_retention_period    = 0
  deletion_protection        = false

  tags = {
    Name = "${var.rds_identifier_base_name}-${local.random_suffix}"
  }
}
