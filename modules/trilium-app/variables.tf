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
  default     = "app"
}

variable "stage" {
  description = "Stage of deployment"
  type        = string
  default     = "production"
}

variable "subnet_id" {
  description = "ID of subnet to place the instance"
  type        = string
}

variable "instance_sg_ids" {
  description = "IDs of security groups to apply to the instance"
  type        = list(string)
}

variable "instance_type" {
  description = "Type of instance to create"
  type        = string
  default     = "t2.micro"
}

variable "instance_pubkey" {
  description = "Public key for ssh connection to instances"
  type        = string
  sensitive   = true
}
