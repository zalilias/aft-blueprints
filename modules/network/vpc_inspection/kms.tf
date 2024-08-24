# Copyright Amazon.com, Inc. or its affiliates. All rights reserved.
# SPDX-License-Identifier: Apache-2.0

resource "aws_kms_key" "nfw" {
  description             = "${local.firewall_name} CMK"
  enable_key_rotation     = true
  deletion_window_in_days = 10
}

resource "aws_kms_key_policy" "nfw" {
  key_id = aws_kms_key.nfw.id
  policy = data.aws_iam_policy_document.nfw_kms_policy.json
}
