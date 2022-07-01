variable "app_name" {
  description = "Name of this app"
  type        = string
  default     = "Cednore Notes"
}

variable "app" {
  description = "URL friendly name of this app"
  type        = string
  default     = "trilium"
}

variable "module" {
  description = "Module name"
  type        = string
  default     = "end"
}

variable "stage" {
  description = "Stage of deployment"
  type        = string
  default     = "production"
}

variable "domain" {
  description = "Domain of this app"
  type        = string
  default     = "trilium.cednore.com"
}

variable "alternative_domains" {
  description = "Alternative domains of this app"
  type        = list(string)
}

variable "route53_apex_zone_id" {
  description = "Zone ID of master hosted zone"
  type        = string
  sensitive   = true
}

variable "route53_default_ttl" {
  description = "Default TTL for DNS records"
  type        = string
  default     = 3600
}

variable "acm_apex_cert_arn" {
  description = "ARN to the apex domain's certificate to attach onto HTTPS listener"
  type        = string
  sensitive   = true
}

variable "vpc_id" {
  description = "ID of root VPC"
  type        = string
}

variable "app_instance_id" {
  description = "ID of the app instance"
  type        = string
}

variable "app_lb_subnet_ids" {
  description = "IDs of subnets for app load balancer"
  type        = list(string)
}

variable "app_lb_sg_ids" {
  description = "IDs of security groups to apply to the app load balancer"
  type        = list(string)
}

variable "app_lb_log_bucket" {
  description = "S3 bucket to store app load balancer logs"
  type        = string
}

variable "app_lb_tg_port" {
  description = "HTTP port for app load balancer target group to look for"
  type        = string
  default     = 80
}
