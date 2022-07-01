output "app_container_log_group" {
  description = "CloudWatch log group for app containers"
  value       = aws_cloudwatch_log_group.app_containers.name
}

output "app_lb_log_bucket" {
  description = "Bucket name for app load balancer logs"
  value       = aws_s3_bucket.app_lb_logs.bucket
  sensitive   = true
}
