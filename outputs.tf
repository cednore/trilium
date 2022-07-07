output "app_url" {
  description = "URL for this app"
  value       = "https://${var.domain}"
}

output "app_lb_dns_name" {
  description = "Domain name of app load balancer"
  value       = module.end.app_lb_dns_name
  sensitive   = true
}

output "app_instance_public_ip" {
  description = "Public IP of app instance"
  value       = module.app.instance_public_ip
  sensitive   = true
}

output "app_instance_username" {
  description = "User name for app instance"
  value       = module.app.instance_username
  sensitive   = true
}

output "app_container_name_prefix" {
  description = "Name prefix of app containers"
  value       = local.app_container_name_prefix
  sensitive   = true
}

output "data_volume_mount_path" {
  description = "Path to mount the data volume device"
  value       = local.data_volume_mount_path
  sensitive   = true
}
