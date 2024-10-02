# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
# SPDX-License-Identifier: Apache-2.0

resource "aws_iam_role" "backup_operator" {
  count = var.create_backup_roles ? 1 : 0

  name = local.backup_operator_role_name
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Principal = {
          Service = "backup.amazonaws.com"
        }
        Effect = "Allow"
        Sid    = ""
      }
    ]
  })
  managed_policy_arns = [
    "arn:aws:iam::aws:policy/service-role/AWSBackupServiceRolePolicyForBackup",
    "arn:aws:iam::aws:policy/AWSBackupServiceRolePolicyForS3Backup"
  ]
  tags = var.tags
}

resource "aws_iam_role_policy" "backup_operator" {
  count = var.create_backup_roles ? 1 : 0

  name = "AdditionalPermissionsForKmsKeys"
  role = aws_iam_role.backup_operator[0].id
  policy = jsonencode(
    {
      Version = "2012-10-17"
      Statement = [
        {
          Action = [
            "kms:ReEncrypt*",
            "kms:GenerateDataKey"
          ]
          Effect   = "Allow"
          Resource = ["arn:aws:kms:*:${data.aws_caller_identity.current.account_id}:key/*"]
        }
      ]
    }
  )
}

resource "aws_iam_role" "backup_restore" {
  count = var.create_backup_roles ? 1 : 0

  name = local.backup_restore_role_name
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Principal = {
          Service = "backup.amazonaws.com"
        }
        Effect = "Allow"
        Sid    = ""
      }
    ]
  })
  managed_policy_arns = [
    "arn:aws:iam::aws:policy/service-role/AWSBackupServiceRolePolicyForRestores",
    "arn:aws:iam::aws:policy/AWSBackupServiceRolePolicyForS3Restore"
  ]
  tags = var.tags
}

resource "aws_iam_role_policy" "backup_restore" {
  count = var.create_backup_roles ? 1 : 0

  name = "AdditionalPermissionsForIamPassRole"
  role = aws_iam_role.backup_restore[0].id
  policy = jsonencode(
    {
      Version = "2012-10-17"
      Statement = [
        {
          Action = [
            "iam:PassRole",
          ]
          Effect   = "Allow"
          Resource = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/*"
          Condition = {
            StringEquals = {
              "iam:PassedToService" : "ec2.amazonaws.com"
            }
          }
        }
      ]
    }
  )
}

