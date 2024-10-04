# Create a KMS Key for encryption
resource "aws_kms_key" "agoge.io-tf-kms-key-for-s3_encryption" {
  description             = "KMS key to encrypt S3 bucket"
  deletion_window_in_days = 10
  enable_key_rotation     = true
}

# Create a KMS key alias (optional)
resource "aws_kms_alias" "agoge.io-tf-kms-alias-for-s3_encryption" {
  name          = "alias/s3_encryption_key"
  target_key_id = aws_kms_key.s3_encryption.key_id
}

# Create an S3 bucket
resource "aws_s3_bucket" "agoge.io-tf-s3-testing" {
  bucket = "agoge.io-tf-s3-bucket-for-kms-testing" # Replace with a unique bucket name

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm     = "aws:kms"
        kms_master_key_id = aws_kms_key.s3_encryption.arn
      }
    }
  }

  tags = {
    Environment = "testing"
  }

}

# Optionally, create a policy for the S3 bucket (e.g., public access block)
resource "aws_s3_bucket_public_access_block" "block_public_access" {
  bucket = aws_s3_bucket.my_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
