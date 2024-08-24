# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
# SPDX-License-Identifier: Apache-2.0

output "egress_vpc_id" {
  description = "The ID of the egress VPC"
  value       = module.vpc_egress.vpc_id
}

output "egress_vpc_tgw_attachment_id" {
  description = "The ID of the TGW egress VPC attachment"
  value       = module.vpc_egress.tgw_attachment_id
}

output "tgw_id" {
  description = "Transit Gateway Id"
  value       = module.tgw.transit_gateway_id
}

output "tgw_route_table_id" {
  description = "Transit Gateway Id"
  value       = module.tgw.route_table_id
}
