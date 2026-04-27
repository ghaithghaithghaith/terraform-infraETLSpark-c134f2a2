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
