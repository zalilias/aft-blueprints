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

variable "enable_backup_notifications" {
  type        = bool
  description = "Whether enable backup notifications events or not."
  default     = true
}

variable "backup_notification_events" {
  type        = list(string)
  description = "List with backup notification events. See https://docs.aws.amazon.com/aws-backup/latest/devguide/backup-notifications.html for more."
  default = [
    "COPY_JOB_FAILED",
    "BACKUP_JOB_FAILED",
    "S3_BACKUP_OBJECT_FAILED"
  ]
}

variable "tags" {
  type    = map(string)
  default = {}
}
