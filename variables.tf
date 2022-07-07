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

variable "domain" {
  description = "Domain name to host this app"
  type        = string
  default     = "trilium.someone.me"
}

variable "alternative_domains" {
  description = "Alternative domain names to host this app"
  type        = list(string)
  default     = []
}
