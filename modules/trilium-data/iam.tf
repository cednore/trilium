resource "aws_iam_role" "backup_app_data_volume" {
  name               = "ir-${local.slug}-backup-app-data-volume"
  assume_role_policy = data.aws_iam_policy_document.backup_app_data_volume_assume_role.json

  tags = merge(local.default_tags, {
    Name = "ir-${local.slug}-backup-app-data-volume"
  })
}

resource "aws_iam_policy" "backup_app_data_volume" {
  name        = "ip-${local.slug}-backup-app-data-volume"
  description = "Policy for DLM to to backup app data volume"
  policy      = data.aws_iam_policy_document.backup_app_data_volume.json

  tags = merge(local.default_tags, {
    Name = "ip-${local.slug}-backup-app-data-volume"
  })
}

resource "aws_iam_role_policy_attachment" "backup_app_data_volume" {
  role       = aws_iam_role.backup_app_data_volume.name
  policy_arn = aws_iam_policy.backup_app_data_volume.arn
}
