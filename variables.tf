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

variable "domain" {
  description = "Domain name to host this app"
  type        = string
  default     = "trilium.cednore.com"
}

variable "alternative_domains" {
  description = "Alternative domain names to host this app"
  type        = list(string)
  default = [
    "notes.cednore.com",
  ]
}
