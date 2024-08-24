# Copyright Amazon.com, Inc. or its affiliates. All rights reserved.
# SPDX-License-Identifier: Apache-2.0

resource "aws_subnet" "public" {
  for_each = local.azs

  vpc_id                  = aws_vpc.this.id
  cidr_block              = cidrsubnet(local.cidrsubnets[2], local.newbits, each.value.index)
  availability_zone       = each.value.name
  map_public_ip_on_launch = false
  tags = merge(
    { "Name" = "${local.vpc_name}-public-subnet-${each.value.id}" },
    var.tags,
    var.public_subnet_tags
  )
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id
  tags = merge(
    { "Name" = "${local.vpc_name}-public-rtb-${local.region}" },
    var.tags
  )
}

resource "aws_route_table_association" "public" {
  for_each = local.azs

  route_table_id = aws_route_table.public.id
  subnet_id      = aws_subnet.public[each.key].id
}

resource "aws_internet_gateway" "public" {
  vpc_id = aws_vpc.this.id
  tags = merge(
    { "Name" = "${local.vpc_name}-igw-${local.region}" },
    var.tags
  )
}

resource "aws_route" "public" {
  route_table_id         = aws_route_table.public.id
  gateway_id             = aws_internet_gateway.public.id
  destination_cidr_block = "0.0.0.0/0"
}
