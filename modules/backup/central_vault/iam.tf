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
  tags = var.tags
}

resource "aws_iam_role_policy_attachments_exclusive" "backup_operator" {
  count = var.create_backup_roles ? 1 : 0

  role_name = aws_iam_role.backup_operator[0].name
  policy_arns = [
    "arn:aws:iam::aws:policy/service-role/AWSBackupServiceRolePolicyForBackup",
    "arn:aws:iam::aws:policy/AWSBackupServiceRolePolicyForS3Backup"
  ]
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
  tags = var.tags
}

resource "aws_iam_role_policy_attachments_exclusive" "backup_restore" {
  count = var.create_backup_roles ? 1 : 0

  role_name = aws_iam_role.backup_restore[0].name
  policy_arns = [
    "arn:aws:iam::aws:policy/service-role/AWSBackupServiceRolePolicyForRestores",
    "arn:aws:iam::aws:policy/AWSBackupServiceRolePolicyForS3Restore"
  ]
}

