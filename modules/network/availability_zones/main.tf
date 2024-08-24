# Copyright Amazon.com, Inc. or its affiliates. All rights reserved.
# SPDX-License-Identifier: Apache-2.0

resource "aws_ssm_parameter" "az" {
  # checkov:skip=CKV_AWS_337:This SSM parameter is not a SecureString and there is no need to encrypt it using KMS
  for_each = var.availability_zones

  name        = "/org/core/network/availability-zones/${each.key}"
  type        = "String"
  description = "Availability Zone Id"
  value       = data.aws_availability_zone.az[each.key].zone_id
}
