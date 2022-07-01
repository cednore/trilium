output "app_lb_dns_name" {
  description = "Domain name of app load balancer"
  value       = aws_lb.app.dns_name
  sensitive   = true
}
