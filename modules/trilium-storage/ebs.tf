resource "aws_ebs_volume" "app_data" {
  availability_zone = var.availability_zone
  size              = var.volume_size
  final_snapshot    = true

  tags = merge(local.default_tags, {
    Name = "vol-${local.slug}-app-data"
  })
}

resource "aws_volume_attachment" "app_data" {
  device_name = "/dev/sd${var.device_letter}"
  volume_id   = aws_ebs_volume.app_data.id
  instance_id = var.app_instance_id
}
