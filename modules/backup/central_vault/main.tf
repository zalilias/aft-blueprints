# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
# SPDX-License-Identifier: Apache-2.0

resource "aws_backup_vault" "backup" {
  name        = var.backup_vault_name
  kms_key_arn = aws_kms_key.backup.arn
  tags        = var.tags
  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_backup_vault_policy" "backup" {
  count = var.enable_backup_notifications ? 1 : 0

  backup_vault_name = aws_backup_vault.backup.name
  policy            = data.aws_iam_policy_document.vault.json
}

data "aws_iam_policy_document" "vault" {
  #checkov:skip=CKV_AWS_111:This is KMS resource policy and hence using '*' for resources
  #checkov:skip=CKV_AWS_109:This is KMS resource policy and hence using '*' for resources
  statement {
    sid       = "Allow copy into central vault from all org accounts"
    actions   = ["backup:CopyIntoBackupVault"]
    resources = ["*"]
    principals {
      type        = "AWS"
      identifiers = ["*"]
    }
    condition {
      test     = "StringEquals"
      variable = "aws:PrincipalOrgID"
      values   = [data.aws_organizations_organization.org.id]
    }
    condition {
      test     = "ArnLike"
      variable = "aws:PrincipalArn"
      values   = ["arn:aws:iam::*:role/${local.backup_operator_role_name}"]
    }
  }
}

resource "aws_backup_vault_lock_configuration" "backup" {
  count = var.enable_backup_vault_lock ? 1 : 0

  backup_vault_name   = aws_backup_vault.backup.name
  min_retention_days  = lookup(var.backup_vault_lock_config, "min_retention_days", null)
  max_retention_days  = lookup(var.backup_vault_lock_config, "max_retention_days", null)
  changeable_for_days = lookup(var.backup_vault_lock_config, "changeable_for_days", null)
}

resource "aws_backup_vault_notifications" "backup" {
  count = var.enable_backup_notifications ? 1 : 0

  backup_vault_name   = aws_backup_vault.backup.name
  sns_topic_arn       = aws_sns_topic.notify[0].arn
  backup_vault_events = var.backup_notification_events
}
