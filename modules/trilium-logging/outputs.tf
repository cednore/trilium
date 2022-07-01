output "app_container_log_group" {
  description = "CloudWatch log group for app containers"
  value       = aws_cloudwatch_log_group.app_containers.name
}
