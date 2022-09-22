data "aws_secretsmanager_secret_version" "app_env" {
  secret_id = "scrt-${var.app}-app-${var.stage}-env"
}
