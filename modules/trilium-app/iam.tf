resource "aws_iam_instance_profile" "app" {
  name = "iip-${local.slug}-app"
  role = aws_iam_role.app_instance_profile.name

  tags = merge(local.default_tags, {
    Name = "iip-${local.slug}-app"
  })
}

resource "aws_iam_role" "app_instance_profile" {
  name               = "ir-${local.slug}-app-instance-profile"
  assume_role_policy = data.aws_iam_policy_document.ec2_assume_role.json

  tags = merge(local.default_tags, {
    Name = "ir-${local.slug}-app-instance-profile"
  })
}

resource "aws_iam_policy" "app_instance_profile" {
  name        = "ip-${local.slug}-app-instance-profile"
  description = "Policy for ${var.app} app instance profile"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "logs:CreateLogStream",
          "logs:PutLogEvents",
        ],
        Resource = [
          "*"
        ],
      },
    ]
  })

  tags = merge(local.default_tags, {
    Name = "ip-${local.slug}-app-instance-profile"
  })
}

resource "aws_iam_role_policy_attachment" "app_instance_profile" {
  role       = aws_iam_role.app_instance_profile.name
  policy_arn = aws_iam_policy.app_instance_profile.arn
}
