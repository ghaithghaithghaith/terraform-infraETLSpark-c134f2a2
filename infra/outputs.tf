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
