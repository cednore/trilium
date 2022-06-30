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

variable "ec2_pubkey" {
  description = "Public key for ssh connection to instances"
  type        = string
  sensitive   = true
}
