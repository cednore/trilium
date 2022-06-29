locals {
  app_name = "Cednore Notes"
  app      = "trilium"
  stage    = terraform.workspace

  root_domain = "cednore.com"
  domain      = "trilium.cednore.com"
}
