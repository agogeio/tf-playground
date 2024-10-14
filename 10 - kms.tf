# Create a Customer Managed KMS Key for encryption
resource "aws_kms_key" "s3_encryption_key" {
  description             = "Customer Managed KMS key to encrypt S3 bucket"
  deletion_window_in_days = 10
  enable_key_rotation     = true # Enable automatic key rotation
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key_policy
resource "aws_kms_key_policy" "s3_encryption_key_policy" {
  key_id = aws_kms_key.s3_encryption_key.id
  policy = jsonencode({
    "Version": "2012-10-17"
    "Id": "some_example"
    "Statement": [
      # I believe required to eliminate error: The new key policy will not allow you to update the key policy in the future.
      {
        "Sid": "Allow root tf-console and tf-deployment-group Full Management Access to the Key",
        "Effect": "Allow",
        "Principal": {
          AWS = ["*"]
        },
        "Action": "kms:*",
        "Resource": "*"
      },
      # Allow Inspector2 Full Access to the Key
      {
        "Sid": "Allow Inspector2 Full Access to the Key",
        "Effect": "Allow",
        "Principal": {
          "Service": "inspector2.amazonaws.com"
        },
        "Action": "kms:*",
        "Resource": "*"
      }
    ]
  })
}

# Create a KMS key alias (optional)
resource "aws_kms_alias" "s3_encryption_key_alias" {
  name          = "alias/my_s3_encryption_key"
  target_key_id = aws_kms_key.s3_encryption_key.key_id
}