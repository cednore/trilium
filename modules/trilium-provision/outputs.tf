output "cmd_trilium_data_volume_provisioner" {
  description = "Command to run to trilium data volume provisioner playbook"
  value       = local.cmd_trilium_data_volume_provisioner
  sensitive   = true
}

output "cmd_trilium_installer" {
  description = "Command to run to trilium installer playbook"
  value       = local.cmd_trilium_installer
  sensitive   = true
}
