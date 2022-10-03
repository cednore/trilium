data "aws_kms_key" "s3" {
  key_id = "alias/aws/s3"
}
