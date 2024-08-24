# Copyright Amazon.com, Inc. or its affiliates. All rights reserved.
# SPDX-License-Identifier: Apache-2.0

output "az_keys" {
  value = keys(var.availability_zones)
}

output "az_names" {
  value = values(var.availability_zones)
}
