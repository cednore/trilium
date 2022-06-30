output "data_volume_device_name" {
  description = "Device name of data volume"
  value       = "/dev/xvd${var.device_letter}"
}

output "app_lb_log_bucket" {
  description = "Bucket name for app load balancer logs"
  value       = aws_s3_bucket.app_lb_logs.bucket
}
