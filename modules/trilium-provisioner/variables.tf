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
  default     = "provisioner"
}

variable "stage" {
  description = "Stage of deployment"
  type        = string
  default     = "production"
}

variable "app_instance_public_ip" {
  description = "Public IP address of the app instance"
  type        = string
}

variable "app_privkey_path" {
  description = "Path to private key file for ssh connection to the app instance"
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

variable "app_container_name_prefix" {
  description = "Name prefix of app containers"
  type        = string
  default     = "app"
}

variable "app_container_ports" {
  description = "Ports to publish from the container to the host"
  type        = string
  default     = "8080:8080"
}

variable "app_container_volumes" {
  description = "Volumes to mount within the container"
  type        = string
  default     = "/mnt/app_data:/home/node/trilium-data"
}

variable "data_volume_device_name" {
  description = "Device name of data volume"
  type        = string
  default     = "/dev/xvdf"
}

variable "data_volume_filesystem" {
  description = "Filesystem of data volume"
  type        = string
  default     = "ext4"
}

variable "data_volume_mount_path" {
  description = "Path to mount the data volume device"
  type        = string
  default     = "/mnt/app_data"
}
