# Create the S3 bucket without inline encryption
resource "aws_s3_bucket" "agoge-tf-s3-bucket" {
  bucket        = "agoge-tf-s3-bucket" # Replace with a unique bucket name
  force_destroy = true # force_destroy will delete S3 buckets even if they have data in them, be careful
}

# Separate Server-Side Encryption Configuration for S3 Bucket using Customer Managed KMS Key
#! https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_server_side_encryption_configuration
resource "aws_s3_bucket_server_side_encryption_configuration" "my_bucket_encryption" {
  bucket = aws_s3_bucket.agoge-tf-s3-bucket.bucket

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.s3_encryption_key.arn
      sse_algorithm     = "aws:kms"
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

resource "aws_s3_bucket_policy" "agoge-tf-s3_bucket_policy" {
  bucket = aws_s3_bucket.agoge-tf-s3-bucket.id
  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [{
      "Sid": "Allow Inspector",
      "Principal": {
        "Service": "inspector2.amazonaws.com"
      },
      "Effect": "Allow",
      "Action": "s3:*",
      "Resource": [
        aws_s3_bucket.agoge-tf-s3-bucket.arn,
        "${aws_s3_bucket.agoge-tf-s3-bucket.arn}/*"
      ]
    }]
  })
}