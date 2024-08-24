# Copyright Amazon.com, Inc. or its affiliates. All rights reserved.
# SPDX-License-Identifier: Apache-2.0

locals {
  tags     = jsondecode(lookup(module.aft_custom_fields.values, "tags", {}))
  regions  = jsondecode(lookup(module.aft_custom_fields.values, "regions", "[\"primary\"]"))
  vpc      = jsondecode(lookup(module.aft_custom_fields.values, "vpc", null))
  phz_name = lookup(module.aft_custom_fields.values, "phz_name", null)
}
