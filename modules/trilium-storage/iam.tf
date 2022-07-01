resource "aws_iam_role" "ebs_snapshot" {
  name = "ir-${local.slug}-ebs-snapshot"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Action = "sts:AssumeRole"
      Principal = {
        Service = "events.amazonaws.com"
      }
    }]
  })
}

resource "aws_iam_policy" "ebs_snapshot" {
  name = "ip-${local.slug}-ebs-snapshot"
  description = "Grant EBS snapshot permissions to CW event rule"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Sid = "CloudWatchEventsBuiltInTargetExecutionAccess"
      Effect = "Allow"
      Action = [
        "ec2:CreateSnapshot"
      ],
      Resource = [
        "*"
      ]
    }]
  })
}

resource "aws_iam_role_policy_attachment" "ebs_snapshot" {
  role       = aws_iam_role.ebs_snapshot.name
  policy_arn = aws_iam_policy.ebs_snapshot.arn
}
