# Copyright Amazon.com, Inc. or its affiliates. All rights reserved.
# SPDX-License-Identifier: Apache-2.0

resource "aws_dx_gateway_association" "this" {
  dx_gateway_id         = var.dx_gateway_id
  associated_gateway_id = var.associated_gateway_id
  allowed_prefixes      = var.allowed_prefixes
}

resource "aws_ec2_transit_gateway_route_table_association" "this" {
  transit_gateway_attachment_id  = data.aws_ec2_transit_gateway_dx_gateway_attachment.this.id
  transit_gateway_route_table_id = var.tgw_rt_association
}

resource "aws_ec2_transit_gateway_route_table_propagation" "this" {
  for_each = var.tgw_rt_propagations

  transit_gateway_attachment_id  = data.aws_ec2_transit_gateway_dx_gateway_attachment.this.id
  transit_gateway_route_table_id = each.value
}

resource "aws_ec2_tag" "vpc_attachment" {
  resource_id = data.aws_ec2_transit_gateway_dx_gateway_attachment.this.id
  key         = "Name"
  value       = "${aws_dx_gateway_association.this.dx_gateway_owner_account_id}-tgw-attach-dx-gateway"
}
