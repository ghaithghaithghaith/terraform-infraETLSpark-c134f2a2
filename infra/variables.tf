variable "aws_region" {
  type        = string
  description = "AWS region for deployment."
  default     = "us-east-1"
}

variable "script_bucket_base_name" {
  type        = string
  description = "Base name for the Glue scripts S3 bucket."
  default     = "glue-scripts"
}

variable "output_bucket_base_name" {
  type        = string
  description = "Base name for the Glue output S3 bucket."
  default     = "glue-output"
}

variable "glue_job_base_name" {
  type        = string
  description = "Base name for the Glue ETL job."
  default     = "glue-etl-job"
}

variable "glue_role_base_name" {
  type        = string
  description = "Base name for the Glue IAM role."
  default     = "glue-job-role"
}

variable "glue_role_policy_base_name" {
  type        = string
  description = "Base name for the Glue IAM inline policy."
  default     = "glue-job-policy"
}

variable "test_script_filename" {
  type        = string
  description = "Filename for the TEST Glue script object stored under the scripts/ prefix."
  default     = "etl_test.py"
}

variable "rds_vpc_base_name" {
  type        = string
  description = "Base name for the RDS VPC."
  default     = "rds-vpc"
}

variable "rds_igw_base_name" {
  type        = string
  description = "Base name for the RDS internet gateway."
  default     = "rds-igw"
}

variable "rds_subnet_a_base_name" {
  type        = string
  description = "Base name for the first RDS subnet."
  default     = "rds-subnet-a"
}

variable "rds_subnet_b_base_name" {
  type        = string
  description = "Base name for the second RDS subnet."
  default     = "rds-subnet-b"
}

variable "rds_subnet_group_base_name" {
  type        = string
  description = "Base name for the RDS subnet group."
  default     = "rds-subnet-group"
}

variable "rds_security_group_base_name" {
  type        = string
  description = "Base name for the RDS security group."
  default     = "rds-sg"
}

variable "rds_identifier_base_name" {
  type        = string
  description = "Base name for the RDS instance identifier."
  default     = "rds-instance"
}

variable "rds_vpc_cidr" {
  type        = string
  description = "CIDR block for the RDS VPC."
  default     = "10.20.0.0/16"
}

variable "rds_subnet_a_cidr" {
  type        = string
  description = "CIDR block for the first RDS subnet."
  default     = "10.20.1.0/24"
}

variable "rds_subnet_b_cidr" {
  type        = string
  description = "CIDR block for the second RDS subnet."
  default     = "10.20.2.0/24"
}

variable "rds_subnet_a_az" {
  type        = string
  description = "Availability zone for the first RDS subnet."
  default     = "us-east-1a"
}

variable "rds_subnet_b_az" {
  type        = string
  description = "Availability zone for the second RDS subnet."
  default     = "us-east-1b"
}

variable "rds_allowed_cidr" {
  type        = string
  description = "CIDR allowed to access the RDS instance."
  default     = "0.0.0.0/0"
}

variable "rds_engine" {
  type        = string
  description = "RDS engine."
  default     = "mysql"
}

variable "rds_engine_version" {
  type        = string
  description = "RDS engine version."
  default     = "8.0.36"
}

variable "rds_instance_class" {
  type        = string
  description = "RDS instance class."
  default     = "db.t3.micro"
}

variable "rds_db_name" {
  type        = string
  description = "Initial database name."
  default     = "appdb"
}

variable "rds_username" {
  type        = string
  description = "Master username for the RDS instance."
  default     = "admin"
}

variable "rds_password" {
  type        = string
  description = "Master password for the RDS instance."
  default     = "ChangeMe123!"
}

variable "rds_port" {
  type        = number
  description = "Port for the RDS instance."
  default     = 3306
}

variable "rds_allocated_storage" {
  type        = number
  description = "Allocated storage for the RDS instance."
  default     = 20
}
