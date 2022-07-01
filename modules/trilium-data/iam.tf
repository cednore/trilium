resource "aws_iam_role" "ebs_snapshot" {
  name               = "ir-${local.slug}-ebs-snapshot"
  assume_role_policy = data.aws_iam_policy_document.ebs_snapshot_assume_role.json

  tags = merge(local.default_tags, {
    Name = "ir-${local.slug}-ebs-snapshot"
  })
}

resource "aws_iam_policy" "ebs_snapshot" {
  name        = "ip-${local.slug}-ebs-snapshot"
  description = "Grant EBS snapshot permissions to CW event rule"
  policy      = data.aws_iam_policy_document.ebs_snapshot.json

  tags = merge(local.default_tags, {
    Name = "ip-${local.slug}-ebs-snapshot"
  })
}

resource "aws_iam_role_policy_attachment" "ebs_snapshot" {
  role       = aws_iam_role.ebs_snapshot.name
  policy_arn = aws_iam_policy.ebs_snapshot.arn
}
