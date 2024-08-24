# Copyright Amazon.com, Inc. or its affiliates. All rights reserved.
# SPDX-License-Identifier: Apache-2.0

output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "tgw_attachment_id" {
  value = aws_ec2_transit_gateway_vpc_attachment.tgw.id
}

output "subnets" {
  description = "Map of subnet IDs grouped by name"
  value       = { for sub in var.subnets : sub.name => [for subnet in local.subnets : aws_subnet.subnets[subnet.key].id if subnet.name == sub.name] }
}

output "route_tables" {
  description = "Map of route table IDs grouped by name"
  value       = { for sub in var.subnets : sub.name => [for subnet in local.subnets : aws_route_table.subnets[subnet.key].id if subnet.name == sub.name] }
}
