locals {
  aws_region        = get_env("AWS_REGION")
  repo_origin       = get_env("REPO_ORIGIN")
  backend_bucket    = get_env("BACKEND_BUCKET")
  backend_locktable = get_env("BACKEND_LOCKTABLE")

  app_name                = get_env("APP_NAME", "Trilium Notes")
  app                     = get_env("APP", "trilium")
  stage                   = get_env("STAGE", "production")
  domain                  = get_env("DOMAIN", "trilium.someone.me")
  app_instance_public_key = get_env("APP_INSTANCE_PUBLIC_KEY")
}

generate "providers" {
  path      = "providers.tf"
  if_exists = "overwrite_terragrunt"

  contents = <<EOF
    provider "aws" {
      region = "${local.aws_region}"

      default_tags {
        tags = {
          Repo = "${local.repo_origin}"
        }
      }
    }
  EOF
}

remote_state {
  backend = "s3"
  config = {
    encrypt        = true
    region         = local.aws_region
    dynamodb_table = local.backend_locktable
    bucket         = local.backend_bucket
    key            = "${local.app}/terraform.tfstate"
  }

  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
}

inputs = {
  app_name                = local.app_name
  app                     = local.app
  stage                   = local.stage
  domain                  = local.domain
  app_instance_public_key = local.app_instance_public_key
}
