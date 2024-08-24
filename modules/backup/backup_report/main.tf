# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
# SPDX-License-Identifier: Apache-2.0

resource "aws_backup_report_plan" "backup_jobs" {
  count = var.enable_backup_jobs_report ? 1 : 0

  name        = "AWSBackupReportForBackupJobs"
  description = "Last 24h backup jobs"

  report_delivery_channel {
    formats        = ["CSV"]
    s3_bucket_name = aws_s3_bucket.report.id
  }
  report_setting {
    report_template = "BACKUP_JOB_REPORT"
    regions         = var.report_regions
    accounts        = ["root"]
  }
  tags = var.tags
}

resource "aws_backup_report_plan" "backup_copy_jobs" {
  count = var.enable_backup_copy_jobs_report ? 1 : 0

  name        = "AWSBackupReportForCopyJobs"
  description = "Last 24h copy jobs"

  report_delivery_channel {
    formats        = ["CSV"]
    s3_bucket_name = aws_s3_bucket.report.id
  }
  report_setting {
    report_template = "COPY_JOB_REPORT"
    regions         = var.report_regions
    accounts        = ["root"]
  }
  tags = var.tags
}

resource "aws_backup_report_plan" "backup_restore_jobs" {
  count = var.enable_backup_copy_jobs_report ? 1 : 0

  name        = "AWSBackupReportForRestoreJobs"
  description = "Last 24h restore jobs"

  report_delivery_channel {
    formats        = ["CSV"]
    s3_bucket_name = aws_s3_bucket.report.id
  }
  report_setting {
    report_template = "RESTORE_JOB_REPORT"
    regions         = var.report_regions
    accounts        = ["root"]
  }
  tags = var.tags
}
