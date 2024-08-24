# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
# SPDX-License-Identifier: Apache-2.0

data "aws_availability_zone" "az" {
  for_each = var.availability_zones

  name = each.value
}
