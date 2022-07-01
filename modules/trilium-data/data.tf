data "aws_region" "current" {}

data "aws_caller_identity" "current" {}

data "aws_iam_policy_document" "ebs_snapshot_assume_role" {
  statement {
    actions = ["sts:AssumeRole"]
    effect  = "Allow"
    principals {
      type        = "Service"
      identifiers = ["events.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "ebs_snapshot" {
  statement {
    sid       = "CloudWatchEventsBuiltInTargetExecutionAccess"
    actions   = ["ec2:CreateSnapshot"]
    effect    = "Allow"
    resources = ["*"]
  }
}
