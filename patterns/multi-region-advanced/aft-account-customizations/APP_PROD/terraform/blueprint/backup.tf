# Copyright Amazon.com, Inc. or its affiliates. All rights reserved.
# SPDX-License-Identifier: Apache-2.0

module "backup" {
  source = "../../../common/modules/backup/local_vault"

  backup_account_id   = var.backup_account_id
  create_backup_roles = var.create_backup_role
  tags                = var.tags
}
