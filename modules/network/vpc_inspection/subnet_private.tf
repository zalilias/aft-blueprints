# Copyright Amazon.com, Inc. or its affiliates. All rights reserved.
# SPDX-License-Identifier: Apache-2.0

resource "aws_subnet" "private" {
  for_each = local.azs

  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = cidrsubnet(local.cidrsubnets[1], 2, each.value.index)
  availability_zone       = each.value.name
  map_public_ip_on_launch = false

  tags = merge(
    { "Name" = "${local.vpc_name}-private-subnet-${each.value.id}" },
    var.tags
  )
}

resource "aws_route_table" "private" {
  for_each = local.azs

  vpc_id = aws_vpc.vpc.id
  tags = merge(
    { "Name" = "${local.vpc_name}-private-rtb-${each.value.id}" },
    var.tags
  )
}

resource "aws_route_table_association" "private" {
  for_each = local.azs

  route_table_id = aws_route_table.private[each.key].id
  subnet_id      = aws_subnet.private[each.key].id
}

resource "aws_route" "private_ngw" {
  for_each = var.enable_egress ? local.azs : {}

  route_table_id         = aws_route_table.private[each.key].id
  nat_gateway_id         = aws_nat_gateway.ngw[each.key].id
  destination_cidr_block = "0.0.0.0/0"
}

resource "aws_route" "private_tgw" {
  for_each = { for route in local.internal_tgw_routes : "${route.id}_${route.cidr}" => route }

  route_table_id         = aws_route_table.private[each.value.id].id
  transit_gateway_id     = aws_ec2_transit_gateway_vpc_attachment.tgw.transit_gateway_id
  destination_cidr_block = each.value.cidr
}
