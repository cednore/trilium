variable "app_name" {
  description = "Name of this app"
  type        = string
  default     = "Trilium Notes"
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
  description = "Domain name to host this app"
  type        = string
  default     = "trilium.someone.me"
}

variable "route53_default_ttl" {
  description = "Default TTL for DNS records"
  type        = string
  default     = 3600
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
