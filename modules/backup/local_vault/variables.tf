# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
# SPDX-License-Identifier: Apache-2.0

variable "backup_vault_name" {
  type        = string
  description = "Backup vault name"
  default     = "local-vault"
}

variable "backup_account_id" {
  type        = string
  description = "Backup account id."
}

variable "create_backup_roles" {
  type        = bool
  description = "Whether create backup service roles"
  default     = false
}

variable "tags" {
  type    = map(string)
  default = {}
}
