provider "aws" {
  region = var.AWS_REGION

  default_tags {
    tags = {
      Repo = var.REPO_ORIGIN
    }
  }
}
