resource "aws_s3_bucket" "app_lb_logs" {
  bucket = "s3b-${local.slug}-app-lb-logs"

  force_destroy = "production" != var.stage

  tags = merge(local.default_tags, {
    Name = "s3b-${local.slug}"
  })
}

resource "aws_s3_bucket_policy" "app_lb_logs" {
  bucket = aws_s3_bucket.app_lb_logs.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = "s3:PutObject",
        Effect   = "Allow"
        Resource = "${aws_s3_bucket.app_lb_logs.arn}/*"
        Principal = {
          AWS = "${data.aws_elb_service_account.main.arn}"
        }
      },
      {
        Action   = "s3:PutObject",
        Effect   = "Allow"
        Resource = "${aws_s3_bucket.app_lb_logs.arn}/*"
        Principal = {
          Service = "delivery.logs.amazonaws.com"
        }
      },
      {
        Action   = "s3:GetBucketAcl",
        Effect   = "Allow"
        Resource = aws_s3_bucket.app_lb_logs.arn
        Principal = {
          Service = "delivery.logs.amazonaws.com"
        }
      },
    ]
  })
}
