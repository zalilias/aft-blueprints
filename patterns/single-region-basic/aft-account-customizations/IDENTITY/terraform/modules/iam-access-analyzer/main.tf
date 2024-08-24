# Copyright Amazon.com, Inc. or its affiliates. All rights reserved.
# SPDX-License-Identifier: Apache-2.0

resource "aws_accessanalyzer_analyzer" "this" {
  analyzer_name = var.name
  type          = var.type
  tags          = var.tags
}
