output "vpc_id" {
  description = "ID of root VPC"
  value       = aws_vpc.root.id
}

output "subnet_ids" {
  description = "Subnet IDs of root VPC"
  value       = [for sn in aws_subnet.public : sn.id]
}

output "public_subnet_ids" {
  description = "Public subnet IDs of root VPC"
  value       = [for sn in aws_subnet.public : sn.id]
}

output "app_instance_sg_ids" {
  description = "Security group IDs to apply on app instance"
  value = [
    aws_security_group.app.id,
    aws_security_group.ssh.id,
  ]
}
