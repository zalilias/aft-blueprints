# Copyright Amazon.com, Inc. or its affiliates. All rights reserved.
# SPDX-License-Identifier: Apache-2.0

locals {
  vpc_name = "endpoints-vpc"
  region   = data.aws_region.current.name

  azs = {
    for i, az in keys(var.az_set) : az => {
      index = i
      id    = az
      name  = var.az_set[az]
    }
  }

  subnets = flatten(
    [for sub in var.subnets :
      [for key, az in local.azs :
        {
          key            = "${sub.name}_${key}"
          name           = sub.name
          newbits        = sub.newbits
          index          = sum([sub.index, az.index])
          tgw_attachment = lookup(sub, "tgw_attachment", false)
          vpc_endpoint   = lookup(sub, "vpc_endpoint", false)
          tags           = lookup(sub, "tags", {})
          az_id          = az.id
          az_name        = az.name
        }
      ]
    ]
  )
}
