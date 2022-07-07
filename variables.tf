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

variable "alternative_domains" {
  description = "Alternative domains of this app"
  type        = list(string)
  default = [
    "notes.cednore.com",
  ]
}
