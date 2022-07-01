resource "aws_cloudwatch_log_group" "app_containers" {
  name              = "cwlg-${local.slug}-app-containers"
  retention_in_days = 0 // Forever

  tags = merge(local.default_tags, {
    Name = "cwlg-${local.slug}-app-containers"
  })
}
