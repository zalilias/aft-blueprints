# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
# SPDX-License-Identifier: Apache-2.0

variable "report_s3_bucket_name" {
  type        = string
  description = "S3 Bucket name for AWS Backup reports"
  default     = ""
}

variable "report_regions" {
  type        = list(string)
  description = "List of regions to report on"
}

variable "enable_backup_jobs_report" {
  type        = bool
  description = "Whether enable report for backup jobs"
  default     = true
}

variable "enable_backup_copy_jobs_report" {
  type        = bool
  description = "Whether enable report for backup copy jobs"
  default     = true
}

variable "enable_backup_restore_jobs_report" {
  type        = bool
  description = "Whether enable report for restore copy jobs"
  default     = true
}

variable "tags" {
  type    = map(string)
  default = {}
}
