# Create an S3 bucket without the encryption block
resource "aws_s3_bucket" "agoge-tf-s3-bucket" {
  bucket = "agoge-tf-s3-bucket-for-inspector"  # Replace with a unique bucket name
  # Other configurations like versioning, logging, etc., can go here
}

# Separate server-side encryption configuration
resource "aws_s3_bucket_server_side_encryption_configuration" "agoge-tf-s3-bucket_encryption" {
  bucket = aws_s3_bucket.agoge-tf-s3-bucket.bucket

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = "aws:kms"
      kms_master_key_id = aws_kms_key.s3_encryption.arn
    }
  }
}

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

# Optionally, create a public access block to restrict public access
resource "aws_s3_bucket_public_access_block" "block_public_access" {
  bucket = aws_s3_bucket.agoge-tf-s3-bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}