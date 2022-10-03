resource "aws_cloudwatch_log_group" "app" {
  name              = "cwlg-${local.slug}-app"
  retention_in_days = var.log_retention

  tags = merge(local.default_tags, {
    Name = "cwlg-${local.slug}-app"
  })
}

resource "aws_cloudwatch_log_group" "proxy" {
  name              = "cwlg-${local.slug}-proxy"
  retention_in_days = var.log_retention

  tags = merge(local.default_tags, {
    Name = "cwlg-${local.slug}-proxy"
  })
}
