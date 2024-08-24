# Copyright Amazon.com, Inc. or its affiliates. All rights reserved.
# SPDX-License-Identifier: Apache-2.0

resource "aws_subnet" "private" {
  for_each = local.azs

  vpc_id                  = aws_vpc.this.id
  cidr_block              = cidrsubnet(local.cidrsubnets[0], local.newbits, each.value.index)
  availability_zone       = each.value.name
  map_public_ip_on_launch = false
  tags = merge(
    { "Name" = "${local.vpc_name}-private-subnet-${each.value.id}" },
    var.tags,
    var.private_subnet_tags
  )
}

resource "aws_route_table" "private" {
  for_each = local.azs

  vpc_id = aws_vpc.this.id
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

resource "aws_route" "private" {
  for_each   = local.azs
  depends_on = [module.tgw_vpc_attachment]

  route_table_id         = aws_route_table.private[each.key].id
  transit_gateway_id     = module.tgw_vpc_attachment.transit_gateway_id
  destination_cidr_block = "0.0.0.0/0"
}
