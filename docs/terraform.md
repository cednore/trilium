# Terraform

[![Infrastructure](https://github.com/cednore/trilium/actions/workflows/infrastructure.yml/badge.svg)](https://github.com/cednore/trilium/actions/workflows/infrastructure.yml)
[![Security](https://github.com/cednore/trilium/actions/workflows/security.yml/badge.svg)](https://github.com/cednore/trilium/actions/workflows/security.yml)
[![Lint](https://github.com/cednore/trilium/actions/workflows/lint.yml/badge.svg)](https://github.com/cednore/trilium/actions/workflows/lint.yml)

[![AWS](https://img.shields.io/badge/AWS-%23FF9900.svg?style=for-the-badge&logo=amazon-aws&logoColor=white)](https://aws.amazon.com/)
[![Docker](https://img.shields.io/badge/docker-%230db7ed.svg?style=for-the-badge&logo=docker&logoColor=white)](https://docker.com/)
[![Terraform](https://img.shields.io/badge/terraform-%235835CC.svg?style=for-the-badge&logo=terraform&logoColor=white)](https://terraform.io/)
[![Terragrunt](https://img.shields.io/badge/Terragrunt-2274EA?style=for-the-badge&logo=data:image/png;base64,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)](https://terragrunt.gruntwork.io/)
[![Ansible](https://img.shields.io/badge/ansible-%231A1918.svg?style=for-the-badge&logo=ansible&logoColor=white)](https://ansible.com/)

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 4.31 |
| <a name="requirement_local"></a> [local](#requirement\_local) | ~> 2.2 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.31.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_app"></a> [app](#module\_app) | ./modules/trilium-app | n/a |
| <a name="module_data"></a> [data](#module\_data) | ./modules/trilium-data | n/a |
| <a name="module_end"></a> [end](#module\_end) | ./modules/trilium-end | n/a |
| <a name="module_log"></a> [log](#module\_log) | ./modules/trilium-log | n/a |
| <a name="module_provision"></a> [provision](#module\_provision) | ./modules/trilium-provision | n/a |
| <a name="module_root"></a> [root](#module\_root) | ./modules/trilium-root | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_secretsmanager_secret_version.app_env](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/secretsmanager_secret_version) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app"></a> [app](#input\_app) | URL friendly name of this app | `string` | `"trilium"` | no |
| <a name="input_app_name"></a> [app\_name](#input\_app\_name) | Name of this app | `string` | `"Trilium Notes"` | no |
| <a name="input_domain"></a> [domain](#input\_domain) | Domain name to host this app | `string` | `"trilium.someone.me"` | no |
| <a name="input_stage"></a> [stage](#input\_stage) | Stage of deployment | `string` | `"production"` | no |

## Outputs

| Name | Description | Value | Sensitive |
|------|-------------|-------|:---------:|
| <a name="output_app_instance_public_ip"></a> [app\_instance\_public\_ip](#output\_app\_instance\_public\_ip) | Public IP of app instance | `<sensitive>` | yes |
| <a name="output_app_lb_dns_name"></a> [app\_lb\_dns\_name](#output\_app\_lb\_dns\_name) | Domain name of app load balancer | `<sensitive>` | yes |
| <a name="output_app_url"></a> [app\_url](#output\_app\_url) | URL for this app | `"https://notes.cednore.me"` | no |
| <a name="output_cmd_download_app_db"></a> [cmd\_download\_app\_db](#output\_cmd\_download\_app\_db) | Command to download app db file (sqlite) | `<sensitive>` | yes |
| <a name="output_cmd_restart_app_container"></a> [cmd\_restart\_app\_container](#output\_cmd\_restart\_app\_container) | Command to restart app instance | `<sensitive>` | yes |
| <a name="output_cmd_ssh_to_app_instance"></a> [cmd\_ssh\_to\_app\_instance](#output\_cmd\_ssh\_to\_app\_instance) | Command to ssh into app instance | `<sensitive>` | yes |
| <a name="output_cmd_trilium_data_volume_provisioner"></a> [cmd\_trilium\_data\_volume\_provisioner](#output\_cmd\_trilium\_data\_volume\_provisioner) | Command to run to trilium data volume provisioner playbook | `<sensitive>` | yes |
| <a name="output_cmd_trilium_installer"></a> [cmd\_trilium\_installer](#output\_cmd\_trilium\_installer) | Command to run to trilium installer playbook | `<sensitive>` | yes |
| <a name="output_cmd_upload_app_db"></a> [cmd\_upload\_app\_db](#output\_cmd\_upload\_app\_db) | Command to upload app db file (sqlite) | `<sensitive>` | yes |
<!-- END_TF_DOCS -->
