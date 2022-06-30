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

variable "vpc_id" {
  description = "ID of root VPC"
  type        = string
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

variable "instance_privkey_path" {
  description = "Path to private key file for ssh connection to instances"
  type        = string
}

variable "app_image" {
  description = "App docker image"
  type        = string
  default     = "zadam/trilium"
}

variable "app_image_tag" {
  description = "Tag for app docker image"
  type        = string
  default     = "0.52.3"
}

variable "app_container_count" {
  description = "Number of app containers to run"
  type        = number
  default     = 1
}

variable "app_container_name" {
  description = "Name prefix of app containers"
  type        = string
  default     = "app"
}

variable "app_container_command" {
  description = "Init command of app containers"
  type        = string
  default     = "sleep 1d"
}
