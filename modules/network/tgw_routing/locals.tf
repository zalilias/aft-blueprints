# Copyright Amazon.com, Inc. or its affiliates. All rights reserved.
# SPDX-License-Identifier: Apache-2.0

locals {
  routes = flatten(
    [for key, value in var.routing_config :
      [for rt in value.routes :
        [for cidr in rt.destination_cidr_blocks : {
          id                     = "${key}_${cidr}"
          tgw_route_table_id     = value.tgw_route_table_id
          destination_cidr_block = cidr
          tgw_attachment_id      = lookup(rt, "tgw_attachment_id", null)
          blackhole              = lookup(rt, "blackhole", null)
          }
        ]
      ]
    ]
  )
}
