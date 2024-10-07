# Create a Customer Managed KMS Key for encryption
resource "aws_kms_key" "s3_encryption" {
  description             = "Customer Managed KMS key to encrypt S3 bucket"
  deletion_window_in_days = 10
  enable_key_rotation     = true # Enable automatic key rotation

  policy = <<EOF
  {
    "Version": "2012-10-17",
    "Id": "key-policy",
    "Statement": [
      {
        "Sid": "Enable IAM User Permissions",
        "Effect": "Allow",
        "Principal": {
          "AWS": "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
        },
        "Action": "kms:*",
        "Resource": "*"
      },
      {
        "Sid": "Allow S3 Use of the Key",
        "Effect": "Allow",
        "Principal": {
          "Service": "s3.amazonaws.com"
        },
        "Action": [
          "kms:Encrypt",
          "kms:Decrypt",
          "kms:ReEncrypt*",
          "kms:GenerateDataKey*",
          "kms:DescribeKey"
        ],
        "Resource": "*",
        "Condition": {
          "StringEquals": {
            "kms:ViaService": "s3.${data.aws_region.current.name}.amazonaws.com",
            "kms:CallerAccount": "${data.aws_caller_identity.current.account_id}"
          }
        }
      },
      {
        "Sid": "Allow tf.user to manage and use the KMS key",
        "Effect": "Allow",
        "Principal": {
          "AWS": "arn:aws:iam::${data.aws_caller_identity.current.account_id}:user/tf.user"
        },
        "Action": [
          "kms:Create*",
          "kms:Describe*",
          "kms:Enable*",
          "kms:List*",
          "kms:Put*",
          "kms:Update*",
          "kms:Revoke*",
          "kms:Disable*",
          "kms:Get*",
          "kms:Delete*",
          "kms:TagResource",
          "kms:UntagResource",
          "kms:ScheduleKeyDeletion",
          "kms:CancelKeyDeletion",
          "kms:Encrypt",
          "kms:Decrypt",
          "kms:ReEncrypt*",
          "kms:GenerateDataKey*",
          "kms:GenerateDataKeyPair*"
        ],
        "Resource": "*"
      }
    ]
  }
  EOF
}

# Create a KMS key alias (optional)
resource "aws_kms_alias" "s3_encryption_alias" {
  name          = "alias/my_s3_encryption_key"
  target_key_id = aws_kms_key.s3_encryption.key_id
}

# Data sources to fetch AWS Account details
data "aws_caller_identity" "current" {}

data "aws_region" "current" {}
