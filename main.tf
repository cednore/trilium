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

  stage                 = local.stage
  subnet_id             = module.root.public_subnet_ids[0]
  instance_sg_ids       = module.root.instance_sg_ids
  instance_pubkey       = var.ec2_pubkey
}

module "storage" {
  source = "./modules/trilium-storage"

  stage                  = local.stage
  app_instance_id        = module.app.instance_id
  availability_zone      = module.app.instance_availability_zone
  device_name            = "/dev/sdf"
}
