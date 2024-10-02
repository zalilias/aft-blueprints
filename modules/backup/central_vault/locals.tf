# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
# SPDX-License-Identifier: Apache-2.0

locals {
  backup_operator_role_name = "AWSCustomerBackupOperatorRole"
  backup_restore_role_name  = "AWSCustomerBackupRestoreRole"
  changeable_for_days       = lookup(var.backup_vault_lock_config, "changeable_for_days", null)
}

