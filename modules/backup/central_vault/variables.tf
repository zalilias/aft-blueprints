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

variable "enable_backup_notifications" {
  type        = bool
  description = "Whether enable backup notifications events"
  default     = true
}

variable "backup_notification_events" {
  type        = list(string)
  description = "List with backup notification events. See https://docs.aws.amazon.com/aws-backup/latest/devguide/backup-notifications.html for more."
  default = [
    "COPY_JOB_FAILED",
    "S3_BACKUP_OBJECT_FAILED"
  ]
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
