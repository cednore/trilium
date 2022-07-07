resource "aws_dlm_lifecycle_policy" "backup_app_data_volume" {
  description        = "Backup ${var.app} app data volume"
  execution_role_arn = aws_iam_role.backup_app_data_volume.arn
  state              = "ENABLED"

  policy_details {
    resource_types = ["VOLUME"]

    schedule {
      name = "Every sunday"

      create_rule {
        cron_expression = "cron(0 0 ? * 7 *)"
      }

      retain_rule {
        count = var.snapshot_retain_count
      }

      tags_to_add = {
        SnapshotCreator = "DLM"
      }

      copy_tags = true
    }

    target_tags = aws_ebs_volume.app_data.tags
  }

  tags = merge(local.default_tags, {
    Name = "dlmlp-${local.slug}-backup-app-data-volume"
  })
}
