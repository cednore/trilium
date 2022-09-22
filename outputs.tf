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

output "cmd_ssh_to_app_instance" {
  description = "Command to ssh into app instance"
  value       = "ssh -i ${local.keypair_filename} -o IdentitiesOnly=yes ${module.app.instance_username}@${module.app.instance_public_ip}"
  sensitive   = true
}

output "cmd_restart_app_container" {
  description = "Command to restart app instance"
  value       = "ssh -i ${local.keypair_filename} -o IdentitiesOnly=yes ${module.app.instance_username}@${module.app.instance_public_ip} sudo docker restart ${local.app_container_name_prefix}1"
  sensitive   = true
}

output "cmd_download_app_db" {
  description = "Command to download app db file (sqlite)"
  value       = "scp -i ${local.keypair_filename} -o IdentitiesOnly=yes ${module.app.instance_username}@${module.app.instance_public_ip}:${local.data_volume_mount_path}/document.db ."
  sensitive   = true
}

output "cmd_upload_app_db" {
  description = "Command to upload app db file (sqlite)"
  value       = "scp -i ${local.keypair_filename} -o IdentitiesOnly=yes document.db ${module.app.instance_username}@${module.app.instance_public_ip}:${local.data_volume_mount_path}/document.db"
  sensitive   = true
}

output "cmd_trilium_data_volume_provisioner" {
  description = "Command to run to trilium data volume provisioner playbook"
  value       = module.provision.cmd_trilium_data_volume_provisioner
  sensitive   = true
}

output "cmd_trilium_installer" {
  description = "Command to run to trilium installer playbook"
  value       = module.provision.cmd_trilium_installer
  sensitive   = true
}
