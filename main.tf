terraform {
  required_version = ">= 1.3"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.20"
    }
  }
}

module "root" {
  source = "./modules/trilium-root"

  app_name    = var.app_name
  app         = var.app
  stage       = var.stage
  vpc_cidr    = "10.0.0.0/16"
  vpc_subnets = 3
}

module "app" {
  source = "./modules/trilium-app"

  app_name      = var.app_name
  app           = var.app
  stage         = var.stage
  subnet_id     = module.root.public_subnet_ids[0]
  sg_ids        = module.root.app_instance_sg_ids
  instance_type = "t3.micro"
  pubkey        = trimspace(local.app_env_secrets.app_instance_public_key)
}

module "data" {
  source = "./modules/trilium-data"

  app_name              = var.app_name
  app                   = var.app
  stage                 = var.stage
  app_instance_id       = module.app.instance_id
  availability_zone     = module.app.instance_availability_zone
  device_letter         = "f" # /dev/sdf, /dev/xvdf
  volume_size           = 20  # 20 GB
  snapshot_retain_count = 4   # keep last 4 snapshots
}

module "log" {
  source = "./modules/trilium-log"

  app_name                = var.app_name
  app                     = var.app
  stage                   = var.stage
  container_log_retention = 120 # days
}

module "end" {
  source = "./modules/trilium-end"

  app_name          = var.app_name
  app               = var.app
  stage             = var.stage
  domain            = var.domain
  vpc_id            = module.root.vpc_id
  app_instance_id   = module.app.instance_id
  app_lb_subnet_ids = module.root.public_subnet_ids
  app_lb_sg_ids     = module.root.app_lb_sg_ids
  app_lb_log_bucket = module.log.app_lb_log_bucket
  app_lb_tg_port    = 80 # http
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
  app_instance_public_ip    = module.app.instance_public_ip
  app_keypair_path          = "${abspath(path.root)}/${local.keypair_filename}"
  app_image                 = "zadam/trilium"
  app_image_tag             = "0.55.1"
  app_container_count       = 1
  app_container_name_prefix = local.app_container_name_prefix
  app_container_ports       = "80:8080"
  app_container_data_path   = "/home/node/trilium-data"
  app_container_log_group   = module.log.app_container_log_group
  data_volume_id            = module.data.data_volume_id
  data_volume_filesystem    = "ext4"
  data_volume_mount_path    = local.data_volume_mount_path
}
