output "data_volume_device_name" {
  value = "/dev/xvd${var.device_letter}"
}
