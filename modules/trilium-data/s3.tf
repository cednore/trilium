resource "aws_s3_bucket" "backup" {
  bucket        = "s3b-${local.slug}-backup"
  force_destroy = false

  tags = merge(local.default_tags, {
    Name = "s3b-${local.slug}-backup"
  })
}

resource "aws_s3_bucket_acl" "backup" {
  bucket = aws_s3_bucket.backup.bucket
  acl    = "private"
}

resource "aws_s3_bucket_server_side_encryption_configuration" "backup" {
  bucket = aws_s3_bucket.backup.bucket

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = data.aws_kms_key.s3.arn
      sse_algorithm     = "aws:kms"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "backup" {
  bucket = aws_s3_bucket.backup.bucket

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
