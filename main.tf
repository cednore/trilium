variable "app_name" {
  description = "Name of this app"
  type        = string
  default     = "Trilium Notes"
}

variable "app" {
  description = "URL friendly name of this app"
  type        = string
  default     = "trilium"
}

variable "stage" {
  description = "Stage of deployment"
  type        = string
  default     = "production"
}

variable "domain" {
  description = "Domain name to host this app"
  type        = string
  default     = "trilium.someone.me"
}

locals {
  app_dir = "/opt/trilium"
}

module "root" {
  source = "./modules/trilium-root"

  app_name    = var.app_name
  app         = var.app
  stage       = var.stage
  vpc_cidr    = "10.0.0.0/16"
  vpc_subnets = 3
}

module "cert" {
  source = "./modules/trilium-cert"

  app_name      = var.app_name
  app           = var.app
  stage         = var.stage
  domain        = var.domain
  email_address = local.secret.letsencrypt_contact_email
}

module "app" {
  source = "./modules/trilium-app"

  app_name      = var.app_name
  app           = var.app
  stage         = var.stage
  subnet_id     = module.root.public_subnet_ids[0]
  sg_ids        = module.root.app_instance_sg_ids
  instance_type = "t3.micro"
  pubkey        = trimspace(local.secret.pubkey)
}

module "data" {
  source = "./modules/trilium-data"

  app_name = var.app_name
  app      = var.app
  stage    = var.stage
}

module "log" {
  source = "./modules/trilium-log"

  app_name      = var.app_name
  app           = var.app
  stage         = var.stage
  log_retention = 120 # days
}

module "end" {
  source = "./modules/trilium-end"

  app_name               = var.app_name
  app                    = var.app
  stage                  = var.stage
  domain                 = var.domain
  app_instance_public_ip = module.app.instance_public_ip
}

module "provision" {
  source = "./modules/trilium-provision"
  depends_on = [
    module.root,
    module.app,
    module.data,
    module.log,
    module.end,
  ]

  app_name                  = var.app_name
  app                       = var.app
  stage                     = var.stage
  domain                    = var.domain
  cert                      = module.cert.cert
  app_instance_username     = module.app.instance_username
  app_instance_public_ip    = module.app.instance_public_ip
  app_instance_keypair_path = local.keypair_path
  app_dir                   = local.app_dir
  app_image                 = "zadam/trilium:0.55.1"
  proxy_image               = "nginx:1.23.1-alpine"
  log_group_region          = module.log.log_group_region
  app_log_group             = module.log.app_log_group
  proxy_log_group           = module.log.proxy_log_group
}

output "app_url" {
  description = "URL for this app"
  value       = "https://${var.domain}"
}

output "app_instance_username" {
  description = "User name of the app instance"
  value       = module.app.instance_username
  sensitive   = true
}

output "app_instance_public_ip" {
  description = "Public IP address of the app instance"
  value       = module.app.instance_public_ip
  sensitive   = true
}

output "cmd_trilium_installer" {
  description = "Command to run to trilium installer playbook"
  value       = module.provision.cmd_trilium_installer
  sensitive   = true
}

output "cmd_ssh_to_app_instance" {
  description = "Command to ssh into the app instance"
  value       = "ssh -i ${local.keypair_path} -o IdentitiesOnly=yes ${module.app.instance_username}@${module.app.instance_public_ip}"
  sensitive   = true
}

output "cmd_restart_app_container" {
  description = "Command to restart the app instance"
  value       = "ssh -i ${local.keypair_path} -o IdentitiesOnly=yes ${module.app.instance_username}@${module.app.instance_public_ip} sudo docker restart app"
  sensitive   = true
}

output "cmd_download_app_db" {
  description = "Command to download app db file (sqlite)"
  value       = "scp -i ${local.keypair_path} -o IdentitiesOnly=yes ${module.app.instance_username}@${module.app.instance_public_ip}:${local.app_dir}/document.db ."
  sensitive   = true
}

output "cmd_upload_app_db" {
  description = "Command to upload app db file (sqlite)"
  value       = "scp -i ${local.keypair_path} -o IdentitiesOnly=yes document.db ${module.app.instance_username}@${module.app.instance_public_ip}:${local.app_dir}/document.db"
  sensitive   = true
}
