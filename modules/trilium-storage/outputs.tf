output "data_volume_device_name" {
  value = "/dev/xvd${var.device_letter}"
}

output "app_lb_log_bucket" {
  value = aws_s3_bucket.app_lb_logs.bucket
}
