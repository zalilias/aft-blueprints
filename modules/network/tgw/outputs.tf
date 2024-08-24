# Copyright Amazon.com, Inc. or its affiliates. All rights reserved.
# SPDX-License-Identifier: Apache-2.0

output "transit_gateway_id" {
  description = "Transit Gateway Id"
  value       = aws_ec2_transit_gateway.this.id
}

output "route_table_id" {
  description = "Map of Route Table Ids"
  value       = { for rt in var.route_tables : rt => module.route_table[rt].route_table_id }
}

