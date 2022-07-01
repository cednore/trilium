terraform {
  required_version = ">= 1.2"

  backend "s3" {
    encrypt        = true
    region         = "us-east-2"
    bucket         = "tf-common-backend"
    key            = "trilium/terraform.tfstate"
    dynamodb_table = "tf-common-backend"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.20"
    }
  }
}

module "root" {
  source = "./modules/trilium-root"

  stage       = local.stage
  vpc_cidr    = "10.0.0.0/16"
  vpc_subnets = 3
}

module "app" {
  source = "./modules/trilium-app"

  stage         = local.stage
  subnet_id     = module.root.public_subnet_ids[0]
  sg_ids        = module.root.app_instance_sg_ids
  instance_type = "t2.micro"
  pubkey        = trimspace(data.tls_public_key.ec2_pubkey.public_key_openssh)
}

module "data" {
  source = "./modules/trilium-data"

  stage             = local.stage
  app_instance_id   = module.app.instance_id
  availability_zone = module.app.instance_availability_zone
  device_letter     = "f" # /dev/sdf, /dev/xvdf
  volume_size       = 100 # 100 GB
}

module "log" {
  source = "./modules/trilium-log"

  stage = local.stage
}

module "end" {
  source = "./modules/trilium-end"

  stage                = local.stage
  domain               = var.domain
  alternative_domains  = var.alternative_domains
  route53_apex_zone_id = data.aws_route53_zone.apex.zone_id
  route53_default_ttl  = 3600
  acm_apex_cert_arn    = data.aws_acm_certificate.apex.arn
  vpc_id               = module.root.vpc_id
  app_instance_id      = module.app.instance_id
  app_lb_subnet_ids    = module.root.public_subnet_ids
  app_lb_sg_ids        = module.root.app_lb_sg_ids
  app_lb_log_bucket    = module.log.app_lb_log_bucket
  app_lb_tg_port       = 80
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

  stage                     = local.stage
  app_instance_public_ip    = module.app.instance_public_ip
  app_privkey_path          = "${path.root}/${local.private_key_filename}"
  app_image                 = "zadam/trilium"
  app_image_tag             = "0.52.4"
  app_container_count       = 1
  app_container_name_prefix = "app"
  app_container_ports       = "80:8080"
  app_container_volumes     = "${var.data_volume_mount_path}:/home/node/trilium-data"
  app_container_log_group   = module.log.app_container_log_group
  data_volume_device_name   = module.data.data_volume_device_name
  data_volume_filesystem    = "ext4"
  data_volume_mount_path    = var.data_volume_mount_path
}
