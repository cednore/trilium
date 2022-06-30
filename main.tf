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

  stage = local.stage
}

module "app" {
  source = "./modules/trilium-app"

  stage           = local.stage
  subnet_id       = module.root.public_subnet_ids[0]
  instance_sg_ids = module.root.instance_sg_ids
  instance_pubkey = var.ec2_pubkey
}

module "storage" {
  source = "./modules/trilium-storage"

  stage             = local.stage
  app_instance_id   = module.app.instance_id
  availability_zone = module.app.instance_availability_zone
  device_letter     = "f"
}

module "provisioner" {
  source = "./modules/trilium-provisioner"
  depends_on = [
    module.root,
    module.app,
    module.storage,
  ]

  stage                   = local.stage
  app_instance_public_ip  = module.app.instance_public_ip
  app_privkey_path        = "${path.root}/${var.ec2_privkey_path}"
  app_image               = "zadam/trilium"
  app_image_tag           = "0.52.3"
  app_container_count     = 1
  app_container_name      = "app"
  app_container_ports     = "8080:8080"
  app_container_volumes   = "${var.data_volume_mount_path}:/home/node/trilium-data"
  data_volume_device_name = module.storage.data_volume_device_name
  data_volume_mount_path  = var.data_volume_mount_path
}
