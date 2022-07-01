resource "aws_cloudwatch_event_rule" "schedule_backup_app_data" {
  name        = "cwer-${local.slug}-schedule-backup-app-data"
  description = "Backup your trilium app data volume"

  schedule_expression = "cron(0 0 ? * 7 *)" # Weekly, every sunday at midnight
}

resource "aws_cloudwatch_event_target" "schedule_backup_app_data" {
  rule     = aws_cloudwatch_event_rule.schedule_backup_app_data.name
  arn      = "arn:aws:events:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:target/create-snapshot"
  input    = jsonencode(aws_ebs_volume.app_data.id)
  role_arn = aws_iam_role.ebs_snapshot.arn
}
