# Copyright Amazon.com, Inc. or its affiliates. All rights reserved.
# SPDX-License-Identifier: Apache-2.0

resource "aws_subnet" "tgw" {
  for_each = local.azs

  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = cidrsubnet(local.cidrsubnets[0], 2, each.value.index)
  availability_zone       = each.value.name
  map_public_ip_on_launch = false

  tags = merge(
    { "Name" = "${local.vpc_name}-tgw-subnet-${each.value.id}" },
    var.tags
  )
}

resource "aws_route_table" "tgw" {
  for_each = local.azs

  vpc_id = aws_vpc.vpc.id
  tags = merge(
    { "Name" = "${local.vpc_name}-tgw-rtb-${each.value.id}" },
    var.tags
  )
}

resource "aws_route_table_association" "tgw" {
  for_each = local.azs

  route_table_id = aws_route_table.tgw[each.key].id
  subnet_id      = aws_subnet.tgw[each.key].id
}

resource "aws_route" "tgw_nfw" {
  depends_on = [aws_subnet.private]
  for_each   = local.azs

  route_table_id         = aws_route_table.tgw[each.key].id
  vpc_endpoint_id        = element([for e in local.nfw_endpoints : e.id if e.az_name == "${each.value.name}"], 0)
  destination_cidr_block = "0.0.0.0/0"
}


