# Terraform

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.2 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 4.20 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.21.0 |
| <a name="provider_tls"></a> [tls](#provider\_tls) | 3.4.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_app"></a> [app](#module\_app) | ./modules/trilium-app | n/a |
| <a name="module_end"></a> [end](#module\_end) | ./modules/trilium-end | n/a |
| <a name="module_logging"></a> [logging](#module\_logging) | ./modules/trilium-logging | n/a |
| <a name="module_provisioner"></a> [provisioner](#module\_provisioner) | ./modules/trilium-provisioner | n/a |
| <a name="module_root"></a> [root](#module\_root) | ./modules/trilium-root | n/a |
| <a name="module_storage"></a> [storage](#module\_storage) | ./modules/trilium-storage | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_acm_certificate.apex](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/acm_certificate) | data source |
| [aws_route53_zone.apex](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/route53_zone) | data source |
| [tls_public_key.ec2_pubkey](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/data-sources/public_key) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_AWS_REGION"></a> [AWS\_REGION](#input\_AWS\_REGION) | AWS default region | `string` | `"us-east-2"` | no |
| <a name="input_REPO_ORIGIN"></a> [REPO\_ORIGIN](#input\_REPO\_ORIGIN) | Owner repository of this project | `string` | `"https://github.com/cednore/trilium.git"` | no |
| <a name="input_alternative_domains"></a> [alternative\_domains](#input\_alternative\_domains) | Alternative domains of this app | `list(string)` | <pre>[<br>  "notes.cednore.com"<br>]</pre> | no |
| <a name="input_apex_domain"></a> [apex\_domain](#input\_apex\_domain) | Apex domain to host this app | `string` | `"cednore.com"` | no |
| <a name="input_app"></a> [app](#input\_app) | URL friendly name of this app | `string` | `"trilium"` | no |
| <a name="input_app_name"></a> [app\_name](#input\_app\_name) | Name of this app | `string` | `"Cednore Notes"` | no |
| <a name="input_data_volume_mount_path"></a> [data\_volume\_mount\_path](#input\_data\_volume\_mount\_path) | value | `string` | `"/mnt/app_data"` | no |
| <a name="input_domain"></a> [domain](#input\_domain) | Domain of this app | `string` | `"trilium.cednore.com"` | no |

## Outputs

| Name | Description | Value | Sensitive |
|------|-------------|-------|:---------:|
| <a name="output_app_instance_public_ip"></a> [app\_instance\_public\_ip](#output\_app\_instance\_public\_ip) | Public IP address of the app instance | `<sensitive>` | yes |
| <a name="output_app_lb_dns_name"></a> [app\_lb\_dns\_name](#output\_app\_lb\_dns\_name) | Domain name of app load balancer | `<sensitive>` | yes |
| <a name="output_app_url"></a> [app\_url](#output\_app\_url) | URL for this app | `"https://trilium.cednore.com"` | no |
| <a name="output_app_urls"></a> [app\_urls](#output\_app\_urls) | All URLs for this app (including alternative domains) | <pre>[<br>  "https://trilium.cednore.com",<br>  "https://notes.cednore.com"<br>]</pre> | no |
<!-- END_TF_DOCS -->
