output "instance_id" {
  description = "ID of the app instance"
  value       = aws_instance.app.id
}

output "instance_public_ip" {
  description = "Public IP address of the app instance"
  value       = aws_instance.app.public_ip
  sensitive   = true
}

output "instance_username" {
  description = "User name of the app instance"
  value       = "ubuntu"
  sensitive   = true
}

output "instance_availability_zone" {
  description = "Availability zone of the app instance"
  value       = aws_instance.app.availability_zone
}
