# Copyright Amazon.com, Inc. or its affiliates. All rights reserved.
# SPDX-License-Identifier: Apache-2.0

resource "aws_accessanalyzer_analyzer" "this" {
  analyzer_name = var.name
  type          = var.type
  dynamic "configuration" {
    for_each = var.type == "ACCOUNT_UNUSED_ACCESS" || var.type == "ORGANIZATION_UNUSED_ACCESS" ? [1] : []
    content {
      unused_access {
        unused_access_age = var.unused_access_age
      }
    }
  }
  tags = var.tags
}
