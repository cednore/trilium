locals {
  vars = read_terragrunt_config(".vars.hcl")
}

generate "providers" {
  path      = "providers.tf"
  if_exists = "overwrite_terragrunt"

  contents = <<EOF
    provider "aws" {
      region = "${local.vars.inputs.aws_region}"

      default_tags {
        tags = {
          Repo = "${local.vars.inputs.repo_origin}"
        }
      }
    }
  EOF
}

remote_state {
  backend = "s3"
  config = {
    encrypt        = true
    bucket         = local.vars.inputs.backend_bucket
    key            = "${local.vars.inputs.app}/terraform.tfstate"
    region         = local.vars.inputs.aws_region
    dynamodb_table = local.vars.inputs.backend_locktable
  }

  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
}

inputs = {
  app_name            = local.vars.inputs.app_name
  app                 = local.vars.inputs.app
  domain              = local.vars.inputs.domain
  alternative_domains = local.vars.inputs.alternative_domains
}
