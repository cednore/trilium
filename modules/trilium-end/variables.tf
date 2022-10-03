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

variable "app_instance_public_ip" {
  description = "Public IP address of the app instance"
  type        = string
  sensitive   = true
}
