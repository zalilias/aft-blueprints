# Copyright Amazon.com, Inc. or its affiliates. All rights reserved.
# SPDX-License-Identifier: Apache-2.0

resource "aws_ec2_transit_gateway_route" "this" {
  for_each = { for route in local.routes : route.id => route }

  transit_gateway_route_table_id = each.value.tgw_route_table_id
  destination_cidr_block         = each.value.destination_cidr_block
  transit_gateway_attachment_id  = each.value.tgw_attachment_id
  blackhole                      = each.value.blackhole
}
