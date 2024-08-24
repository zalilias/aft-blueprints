# Copyright Amazon.com, Inc. or its affiliates. All rights reserved.
# SPDX-License-Identifier: Apache-2.0

resource "aws_subnet" "private" {
  for_each = local.azs

  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = cidrsubnet(local.cidrsubnets[0], 2, each.value.index)
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

resource "aws_route" "egress" {
  for_each = local.azs

  route_table_id         = aws_route_table.private[each.key].id
  nat_gateway_id         = aws_nat_gateway.ngw[each.key].id
  destination_cidr_block = "0.0.0.0/0"
}


