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
  default     = "root"
}

variable "stage" {
  description = "Stage of deployment"
  type        = string
  default     = "production"
}

variable "vpc_cidr" {
  description = "Base CIDR block of the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "vpc_subnets" {
  description = "Number of private/public subnets of the VPC"
  type        = number
  default     = 1
}
