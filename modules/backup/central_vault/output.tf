# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
# SPDX-License-Identifier: Apache-2.0

output "backup_vault_arn" {
  value = aws_backup_vault.backup.arn
}

output "backup_vault_name" {
  value = aws_backup_vault.backup.name
}

output "backup_operator_role_name" {
  value = local.backup_operator_role_name
}

output "backup_restore_role_name" {
  value = local.backup_restore_role_name
}


