output "app_url" {
  description = "URL for this app"
  value       = "https://${var.domain}"
}

output "app_urls" {
  description = "All URLs for this app (including alternative domains)"
  value       = concat(["https://${var.domain}"], [for name in var.alternative_domains : "https://${name}"])
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
