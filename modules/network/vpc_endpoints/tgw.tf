# Copyright Amazon.com, Inc. or its affiliates. All rights reserved.
# SPDX-License-Identifier: Apache-2.0

resource "aws_ec2_transit_gateway_vpc_attachment" "tgw" {
  depends_on = [aws_subnet.subnets]

  subnet_ids                                      = [for sub in local.subnets : aws_subnet.subnets[sub.key].id if sub.tgw_attachment == true]
  transit_gateway_id                              = var.transit_gateway_id
  vpc_id                                          = aws_vpc.vpc.id
  transit_gateway_default_route_table_association = false
  transit_gateway_default_route_table_propagation = false
  tags = merge(
    { "Name" = "${data.aws_caller_identity.current.account_id}-tgw-attach-${local.vpc_name}" },
    var.tags
  )
}

resource "aws_ec2_transit_gateway_route_table_association" "tgw" {
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.tgw.id
  transit_gateway_route_table_id = var.transit_gateway_route_table_id
}

resource "aws_ec2_transit_gateway_route_table_propagation" "tgw" {
  for_each = var.transit_gateway_propagations

  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.tgw.id
  transit_gateway_route_table_id = each.value
}
