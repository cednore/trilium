output "data_volume_device_name" {
  description = "Device name of data volume"
  value       = "/dev/xvd${var.device_letter}"
}
