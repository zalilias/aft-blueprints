# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
# SPDX-License-Identifier: Apache-2.0

resource "aws_s3_bucket" "report" {
  bucket = var.report_s3_bucket_name == "" ? "aws-backup-reports-${data.aws_caller_identity.current.account_id}" : var.report_s3_bucket_name
  tags   = var.tags
}

resource "aws_s3_bucket_policy" "report" {
  bucket = aws_s3_bucket.report.id
  policy = data.aws_iam_policy_document.report.json
}

data "aws_iam_policy_document" "report" {
  statement {
    sid       = "AWSBackupReportAccess"
    actions   = ["s3:PutObject"]
    resources = ["${aws_s3_bucket.report.arn}/*"]
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/aws-service-role/reports.backup.amazonaws.com/AWSServiceRoleForBackupReports"]
    }
    condition {
      test     = "StringEquals"
      variable = "s3:x-amz-acl"
      values   = ["bucket-owner-full-control"]
    }
  }
}

resource "aws_s3_bucket_public_access_block" "report" {
  bucket                  = aws_s3_bucket.report.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_versioning" "report" {
  bucket = aws_s3_bucket.report.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "report" {
  bucket = aws_s3_bucket.report.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}
