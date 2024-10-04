# Create a KMS Key for encryption
resource "aws_kms_key" "s3_encryption" {
  description             = "KMS key to encrypt S3 bucket"
  deletion_window_in_days = 10
  enable_key_rotation     = true
}

# Create a KMS key alias (optional)
resource "aws_kms_alias" "s3_encryption_alias" {
  name          = "alias/s3_encryption_key"
  target_key_id = aws_kms_key.s3_encryption.key_id
}

