# Copyright Amazon.com, Inc. or its affiliates. All rights reserved.
# SPDX-License-Identifier: Apache-2.0

variable "backup_vault_name" {
  description = "AWS Backup Vault name"
  type        = string
  default     = "central-vault"
}

variable "enable_backup_vault_lock" {
  description = "Whether enable AWS Backup Vault Lock feature or not."
  type        = bool
  default     = true
}

variable "backup_vault_lock_min_retention_days" {
  description = "AWS Backup Vault Lock minimum retention days configuration."
  type        = number
  default     = 7
}

variable "backup_vault_lock_max_retention_days" {
  description = "AWS Backup Vault Lock maximum retention days configuration."
  type        = number
  default     = 365
}

variable "backup_vault_lock_changeable_for_days" {
  description = <<-EOF
    "AWS Backup Vault Lock changeable ofr days configuration. 
    To create vault lock in governance mode inform 0 (zero), for vault lock in compliance mode inform a value >= 3 and <= 36,500.
    See https://docs.aws.amazon.com/aws-backup/latest/devguide/vault-lock.html for more information."
  EOF
  type        = number
  default     = 0
  validation {
    condition     = var.backup_vault_lock_changeable_for_days == 0 || (var.backup_vault_lock_changeable_for_days >= 3 && var.backup_vault_lock_changeable_for_days <= 36500)
    error_message = "The changeable_for_days value must be 0 (for governance mode) or between 3 and 36500 (for compliance mode)."
  }
}

variable "enable_backup_jobs_report" {
  description = "Whether enable AWS Backup report for backup jobs or not."
  type        = bool
  default     = true
}

variable "enable_backup_copy_jobs_report" {
  description = "Whether enable AWS Backup report for backup copy jobs or not."
  type        = bool
  default     = true
}

variable "enable_backup_restore_jobs_report" {
  description = "Whether enable AWS Backup report for backup restore jobs or not."
  type        = bool
  default     = true
}
