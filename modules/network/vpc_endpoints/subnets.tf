# Copyright Amazon.com, Inc. or its affiliates. All rights reserved.
# SPDX-License-Identifier: Apache-2.0

resource "aws_subnet" "subnets" {
  for_each   = { for subnet in local.subnets : subnet.key => subnet }
  depends_on = [aws_vpc.vpc]

  vpc_id            = aws_vpc.vpc.id
  cidr_block        = cidrsubnet(aws_vpc.vpc.cidr_block, each.value.newbits, each.value.index)
  availability_zone = each.value.az_name
  tags = merge(
    { "Name" = "${local.vpc_name}-${each.value.name}-subnet-${each.value.az_id}" },
    var.tags,
    each.value.tags
  )
}

resource "aws_route_table" "subnets" {
  for_each = { for subnet in local.subnets : subnet.key => subnet }

  vpc_id = aws_vpc.vpc.id
  tags = merge(
    { "Name" = "${local.vpc_name}-${each.value.name}-rtb-${each.value.az_id}" },
    var.tags
  )
}

resource "aws_route_table_association" "subnets" {
  for_each = { for subnet in local.subnets : subnet.key => subnet }

  subnet_id      = aws_subnet.subnets[each.key].id
  route_table_id = aws_route_table.subnets[each.key].id
}

resource "aws_route" "subnets" {
  for_each = { for subnet in local.subnets : subnet.key => subnet }

  route_table_id         = aws_route_table.subnets[each.key].id
  transit_gateway_id     = aws_ec2_transit_gateway_vpc_attachment.tgw.transit_gateway_id
  destination_cidr_block = "0.0.0.0/0"
  timeouts {
    create = "10m"
  }
}


