output "app_instance_public_ip" {
  description = "Public IP address of the app instance"
  value       = module.app.instance_public_ip
}

output "app_lb_dns_name" {
  description = "Domain name of app load balancer"
  value       = module.end.app_lb_dns_name
}
