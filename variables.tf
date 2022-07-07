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

variable "app_instance_public_key" {
  description = "SSH public key for the app instance"
  type        = string
  sensitive   = true
}
