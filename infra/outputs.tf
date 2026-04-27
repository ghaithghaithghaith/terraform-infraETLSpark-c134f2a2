output "random_suffix" {
  value = random_string.suffix.result
}

output "script_bucket_name" {
  value = aws_s3_bucket.script_bucket.bucket
}

output "script_bucket_arn" {
  value = aws_s3_bucket.script_bucket.arn
}

output "script_bucket_domain_name" {
  value = aws_s3_bucket.script_bucket.bucket_domain_name
}

output "script_bucket_regional_domain_name" {
  value = aws_s3_bucket.script_bucket.bucket_regional_domain_name
}

output "output_bucket_name" {
  value = aws_s3_bucket.output_bucket.bucket
}

output "output_bucket_arn" {
  value = aws_s3_bucket.output_bucket.arn
}

output "output_bucket_domain_name" {
  value = aws_s3_bucket.output_bucket.bucket_domain_name
}

output "output_bucket_regional_domain_name" {
  value = aws_s3_bucket.output_bucket.bucket_regional_domain_name
}

output "glue_role_name" {
  value = aws_iam_role.glue_job_role.name
}

output "glue_role_arn" {
  value = aws_iam_role.glue_job_role.arn
}

output "glue_job_name" {
  value = aws_glue_job.etl_job.id
}

output "glue_job_arn" {
  value = aws_glue_job.etl_job.arn
}

output "test_script_s3_uri" {
  value = "s3://${aws_s3_bucket.script_bucket.bucket}/${aws_s3_object.test_glue_script.key}"
}

output "output_data_s3_uri" {
  value = "s3://${aws_s3_bucket.output_bucket.bucket}/output/"
}

output "temp_data_s3_uri" {
  value = "s3://${aws_s3_bucket.output_bucket.bucket}/temp/"
}

output "rds_instance_id" {
  value = aws_db_instance.rds.id
}

output "rds_instance_arn" {
  value = aws_db_instance.rds.arn
}

output "rds_instance_address" {
  value = aws_db_instance.rds.address
}

output "rds_instance_endpoint" {
  value = aws_db_instance.rds.endpoint
}

output "rds_instance_port" {
  value = aws_db_instance.rds.port
}

output "rds_instance_username" {
  value = aws_db_instance.rds.username
}

output "rds_instance_db_name" {
  value = aws_db_instance.rds.db_name
}

output "rds_instance_resource_id" {
  value = aws_db_instance.rds.resource_id
}

output "rds_instance_status" {
  value = aws_db_instance.rds.status
}

output "rds_instance_engine" {
  value = aws_db_instance.rds.engine
}

output "rds_instance_engine_version_actual" {
  value = aws_db_instance.rds.engine_version_actual
}

output "rds_instance_availability_zone" {
  value = aws_db_instance.rds.availability_zone
}

output "rds_instance_instance_class" {
  value = aws_db_instance.rds.instance_class
}

output "rds_instance_multi_az" {
  value = aws_db_instance.rds.multi_az
}

output "rds_instance_storage_encrypted" {
  value = aws_db_instance.rds.storage_encrypted
}

output "rds_instance_hosted_zone_id" {
  value = aws_db_instance.rds.hosted_zone_id
}

output "rds_instance_maintenance_window" {
  value = aws_db_instance.rds.maintenance_window
}

output "rds_instance_latest_restorable_time" {
  value = aws_db_instance.rds.latest_restorable_time
}

output "rds_instance_arn_address" {
  value = aws_db_instance.rds.address
}

output "rds_subnet_group_id" {
  value = aws_db_subnet_group.rds.id
}

output "rds_subnet_group_arn" {
  value = aws_db_subnet_group.rds.arn
}

output "rds_subnet_group_vpc_id" {
  value = aws_db_subnet_group.rds.vpc_id
}

output "rds_vpc_id" {
  value = aws_vpc.rds.id
}

output "rds_subnet_a_id" {
  value = aws_subnet.rds_a.id
}

output "rds_subnet_b_id" {
  value = aws_subnet.rds_b.id
}

output "rds_security_group_id" {
  value = aws_security_group.rds.id
}
