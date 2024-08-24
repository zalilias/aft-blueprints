# Copyright Amazon.com, Inc. or its affiliates. All rights reserved.
# SPDX-License-Identifier: Apache-2.0

output "route_table_id" {
  description = "Route Table Id"
  value       = aws_ec2_transit_gateway_route_table.this.id
}
