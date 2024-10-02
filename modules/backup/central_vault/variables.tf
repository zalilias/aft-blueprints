# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
# SPDX-License-Identifier: Apache-2.0

variable "backup_vault_name" {
  type        = string
  description = "Backup vault name"
  default     = "central-vault"
}

variable "enable_backup_vault_lock" {
  type        = bool
  description = "Whether enable backup vault lock"
  default     = true
}

variable "backup_vault_lock_config" {
  type = object({
    min_retention_days  = optional(number)
    max_retention_days  = optional(number)
    changeable_for_days = optional(number)
  })
  description = "Vault lock configuration. See https://docs.aws.amazon.com/aws-backup/latest/devguide/vault-lock.html for more."
  default     = {}
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
