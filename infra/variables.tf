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

variable "rds_vpc_cidr_block" {
  type        = string
  description = "CIDR block for the RDS VPC."
  default     = "10.20.0.0/16"
}

variable "rds_subnet_base_name" {
  type        = string
  description = "Base name for the RDS subnets."
  default     = "rds-subnet"
}

variable "rds_subnet_cidr_blocks" {
  type        = list(string)
  description = "CIDR blocks for the RDS subnets."
  default     = ["10.20.1.0/24", "10.20.2.0/24"]
}

variable "rds_subnet_availability_zones" {
  type        = list(string)
  description = "Availability zones for the RDS subnets."
  default     = ["us-east-1a", "us-east-1b"]
}

variable "rds_security_group_base_name" {
  type        = string
  description = "Base name for the RDS security group."
  default     = "rds-sg"
}

variable "rds_subnet_group_base_name" {
  type        = string
  description = "Base name for the RDS subnet group."
  default     = "rds-subnet-group"
}

variable "rds_identifier_base_name" {
  type        = string
  description = "Base name for the RDS instance identifier."
  default     = "rds-instance"
}

variable "rds_engine" {
  type        = string
  description = "RDS engine."
  default     = "mysql"
}

variable "rds_engine_version" {
  type        = string
  description = "RDS engine version."
  default     = "8.0"
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

variable "rds_allowed_cidr_blocks" {
  type        = list(string)
  description = "CIDR blocks allowed to access the RDS instance."
  default     = ["10.20.0.0/16"]
}

variable "rds_allocated_storage" {
  type        = number
  description = "Allocated storage for the RDS instance."
  default     = 20
}

variable "rds_backup_retention_period" {
  type        = number
  description = "Backup retention period for the RDS instance."
  default     = 0
}
