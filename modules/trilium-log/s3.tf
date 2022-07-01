resource "aws_s3_bucket" "app_lb_logs" {
  bucket        = "s3b-${local.slug}-app-lb-logs"
  force_destroy = "production" != var.stage

  tags = merge(local.default_tags, {
    Name = "s3b-${local.slug}"
  })
}

resource "aws_s3_bucket_policy" "app_lb_logs" {
  bucket = aws_s3_bucket.app_lb_logs.id
  policy = data.aws_iam_policy_document.app_lb_logs.json
}
