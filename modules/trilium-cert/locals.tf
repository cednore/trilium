locals {
  default_tags = {
    App    = var.app
    Module = var.module
    Stage  = var.stage
  }
  slug = "${var.app}-${var.module}-${var.stage}"

  apex_domain = join(".", slice(
    split(".", var.domain),
    length(split(".", var.domain)) - 2,
    length(split(".", var.domain))
  )) # extract apex domain from app domain
}
