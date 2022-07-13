resource "aws_cloudwatch_log_group" "app_containers" {
  name              = "cwlg-${local.slug}-app-containers"
  retention_in_days = var.container_log_retention

  tags = merge(local.default_tags, {
    Name = "cwlg-${local.slug}-app-containers"
  })
}
