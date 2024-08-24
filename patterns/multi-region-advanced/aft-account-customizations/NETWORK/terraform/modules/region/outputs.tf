# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
# SPDX-License-Identifier: Apache-2.0

output "inspection_vpc_id" {
  description = "The ID of the inspection VPC"
  value       = module.vpc_inspection.vpc_id
}

output "inspection_vpc_tgw_attachment_id" {
  description = "The ID of the TGW inspection VPC attachment"
  value       = module.vpc_inspection.tgw_attachment_id
}

output "endpoints_vpc_id" {
  description = "The ID of the enpoints VPC"
  value       = module.vpc_endpoints.vpc_id
}

output "tgw_id" {
  description = "Transit Gateway Id"
  value       = module.tgw.transit_gateway_id
}

output "tgw_route_table_id" {
  description = "Transit Gateway Id"
  value       = module.tgw.route_table_id
}
