variable "AWS_REGION" {
  description = "AWS default region"
  type        = string
  default     = "us-east-2"
}

variable "REPO_ORIGIN" {
  description = "Owner repository of this project"
  type        = string
  default     = "https://github.com/cednore/trilium.git"
}

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

variable "apex_domain" {
  description = "Apex domain to host this app"
  type        = string
  default     = "cednore.com"
}

variable "domain" {
  description = "Domain of this app"
  type        = string
  default     = "trilium.cednore.com"
}

variable "ec2_pubkey" {
  description = "Public key for ssh connection to instances"
  type        = string
  sensitive   = true
}

variable "ec2_privkey_path" {
  description = "Path to private key file for ssh connection to instances"
  type        = string
}

variable "data_volume_mount_path" {
  description = "value"
  type        = string
  default     = "/mnt/app_data"
}
