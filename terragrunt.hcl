# Terragrunt configurations
terraform {
  after_hook "output_json" { # generate json-format output file after apply or plan
    commands = ["apply", "plan"]
    execute  = ["just", "output-json"]
  }
}

# Read environment variables
locals {
  is_ci             = get_env("CI") == "true"
  aws_region        = get_env("AWS_REGION")
  repo_origin       = get_env("REPO_ORIGIN")
  backend_bucket    = get_env("BACKEND_BUCKET")
  backend_locktable = get_env("BACKEND_LOCKTABLE")
  backend_region    = get_env("BACKEND_REGION")

  app_name = get_env("APP_NAME", "Trilium Notes")
  app      = get_env("APP", "trilium")
  stage    = get_env("STAGE", "production")
  domain   = get_env("DOMAIN", "trilium.someone.me")
}

# Generate main terraform block
generate "terraform" {
  path      = "terraform.tf"
  if_exists = "overwrite_terragrunt"

  contents = <<EOF
terraform {
  required_version = ">= 1.3"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.20"
    }

    local = {
      source  = "hashicorp/local"
      version = "~> 2.2"
    }
  }
}
EOF
}

# Generate providers block
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

# Generate remote state block
remote_state {
  backend = "s3"
  config = {
    encrypt        = true
    region         = local.backend_region
    dynamodb_table = local.backend_locktable
    bucket         = local.backend_bucket
    key            = "env:/${local.stage}/${local.app}/terraform.tfstate"
  }

  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
}

# Generate secrets block
generate "secrets" {
  path      = "secrets.tf"
  if_exists = "overwrite_terragrunt"

  contents = <<EOF
locals {
  keypair_filename = ".keypair.pem"
  app_env_secrets  = jsondecode(data.aws_secretsmanager_secret_version.app_env.secret_string)
}

data "aws_secretsmanager_secret_version" "app_env" {
  secret_id = "scrt-$${var.app}-app-$${var.stage}-env"
}

data "aws_s3_object" "keypair" {
  bucket = "${local.backend_bucket}"
  key    = "env:/$${var.stage}/$${var.app}/.keypair.pem"
}

resource "local_sensitive_file" "keypair" {
  count    = ${local.is_ci ? "0" : "1"}
  filename = "$${abspath(path.root)}/$${local.keypair_filename}"
  content  = data.aws_s3_object.keypair.body
}
EOF
}

# Input variables
inputs = {
  app_name = local.app_name
  app      = local.app
  stage    = local.stage
  domain   = local.domain
}
