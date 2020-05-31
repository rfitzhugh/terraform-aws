## =============================================================================
#  Create KMS Key                                                              #
## =============================================================================
resource "aws_kms_key" "example-kms-s3-usw1" {
  description             = "KMS key for Rubrik CloudOut and CloudOn"
  tags = {
    name           = "example-kms-s3-usw1"
    environment    = "management"
  }
  policy = <<EOF
{
    "Id": "key-consolepolicy-3",
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "Enable IAM User Permissions",
            "Effect": "Allow",
            "Principal": {
                "AWS": "arn:aws:iam::000000000000:root"
            },
            "Action": "kms:*",
            "Resource": "*"
        },
        {
            "Sid": "Allow access for Key Administrators",
            "Effect": "Allow",
            "Principal": {
                "AWS": [
                    "arn:aws:iam::000000000000:user/example-iam-svc-usw1",
                ]
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
                "kms:CancelKeyDeletion"
            ],
            "Resource": "*"
        },
        {
            "Sid": "Allow use of the key",
            "Effect": "Allow",
            "Principal": {
                "AWS": "arn:aws:iam::000000000000:user/example-iam-svc-usw1"
            },
            "Action": [
                "kms:Encrypt",
                "kms:Decrypt",
                "kms:ReEncrypt*",
                "kms:GenerateDataKey*",
                "kms:DescribeKey"
            ],
            "Resource": "*"
        },
        {
            "Sid": "Allow attachment of persistent resources",
            "Effect": "Allow",
            "Principal": {
                "AWS": "arn:aws:iam::000000000000:user/example-iam-svc-usw1"
            },
            "Action": [
                "kms:CreateGrant",
                "kms:ListGrants",
                "kms:RevokeGrant"
            ],
            "Resource": "*",
            "Condition": {
                "Bool": {
                    "kms:GrantIsForAWSResource": "true"
                }
            }
        }
    ]
}
EOF
}

resource "aws_kms_alias" "example-kms-s3-usw1" {
  target_key_id = aws_kms_key.example-kms-s3-usw1.key_id
  name          = "alias/example-kms-s3-usw1"
}

## =============================================================================
#  S3 Bucket - USW1 (N. CA)                                                    #
## =============================================================================
resource "aws_s3_bucket" "example-s3-usw1-a" {
  bucket = "example-s3-usw1-a"
  acl    = "private"
  versioning {
    enabled = true
  }

  tags = {
    Name        = "example-s3-usw1-a"
    environment = var.aws_environment_name
    managed-by  = "Terraform"
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = aws_kms_key.example-kms-s3-usw1.key_id
        sse_algorithm     = "aws:kms"
      }
    }
  }
}

# Provides additional layers of security to block all public access to the bucket
resource "aws_s3_bucket_public_access_block" "example-s3-usw1-a" {
  bucket                  = aws_s3_bucket.example-s3-usw1-a.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}