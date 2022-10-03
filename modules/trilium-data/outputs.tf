output "backup_bucket" {
  description = "The name of the S3 bucket to backup the app data."
  value       = aws_s3_bucket.backup.bucket
  sensitive   = true
}
