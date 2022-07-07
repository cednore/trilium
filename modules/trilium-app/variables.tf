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
  default     = "app"
}

variable "stage" {
  description = "Stage of deployment"
  type        = string
  default     = "production"
}

variable "subnet_id" {
  description = "ID of subnet to place the app instance"
  type        = string
}

variable "sg_ids" {
  description = "IDs of security groups to apply to the app instance"
  type        = list(string)
}

variable "instance_type" {
  description = "Type of instance to create"
  type        = string
  default     = "t3.micro"
}

variable "pubkey" {
  description = "SSH public key for the app instance"
  type        = string
  sensitive   = true
}
