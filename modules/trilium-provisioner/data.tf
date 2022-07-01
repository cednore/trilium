data "archive_file" "app_playbook" {
  type        = "zip"
  source_file = "${path.module}/playbooks/app.yml"
  output_path = "${path.module}/archives/app-playbook.zip"
}

data "archive_file" "app_data_playbook" {
  type        = "zip"
  source_file = "${path.module}/playbooks/app-data.yml"
  output_path = "${path.module}/archives/app-data-playbook.zip"
}
