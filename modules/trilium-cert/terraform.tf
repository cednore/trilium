terraform {
  required_version = ">= 1.2"

  required_providers {
    acme = {
      source  = "vancluever/acme"
      version = "~> 2.10"
    }
  }
}
