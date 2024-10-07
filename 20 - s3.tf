# Create the S3 bucket without inline encryption
resource "aws_s3_bucket" "agoge-tf-s3-bucket" {
  bucket = "agoge-tf-s3-bucket" # Replace with a unique bucket name

  # Other bucket configurations can go here
}

# Separate Server-Side Encryption Configuration for S3 Bucket using Customer Managed KMS Key
resource "aws_s3_bucket_server_side_encryption_configuration" "my_bucket_encryption" {
  bucket = aws_s3_bucket.agoge-tf-s3-bucket.bucket

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = "aws:kms"
      kms_master_key_id = aws_kms_key.s3_encryption.arn
    }
  }
}

# Optionally, create a public access block to restrict public access
resource "aws_s3_bucket_public_access_block" "block_public_access" {
  bucket = aws_s3_bucket.agoge-tf-s3-bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
