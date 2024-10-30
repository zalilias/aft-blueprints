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

output "route53_resolver_inbound_endpoint_id" {
  description = "The ID of the inbound endpoint"
  value       = module.route53_resolvers.inbound_endpoint_id
}

output "route53_resolver_inbound_endpoint_ips" {
  description = "The IP addresses of the inbound endpoint"
  value       = module.route53_resolvers.inbound_endpoint_ips
}

output "route53_resolver_outbound_endpoint_id" {
  description = "The ID of the outbound endpoint"
  value       = module.route53_resolvers.outbound_endpoint_id
}

output "route53_resolver_outbound_endpoint_ips" {
  description = "The IP addresses of the outbound endpoint"
  value       = module.route53_resolvers.outbound_endpoint_ips
}
