output "app_log_group" {
  description = "CloudWatch log group for app"
  value       = aws_cloudwatch_log_group.app.name
}

output "proxy_log_group" {
  description = "CloudWatch log group for reverse proxy"
  value       = aws_cloudwatch_log_group.proxy.name
}
