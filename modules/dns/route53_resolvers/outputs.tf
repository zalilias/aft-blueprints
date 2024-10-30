# Copyright Amazon.com, Inc. or its affiliates. All rights reserved.
# SPDX-License-Identifier: Apache-2.0

output "inbound_endpoint_id" {
  value = aws_route53_resolver_endpoint.inbound.id
}

output "inbound_endpoint_ips" {
  value = data.aws_route53_resolver_endpoint.inbound.ip_addresses
}

output "outbound_endpoint_id" {
  value = aws_route53_resolver_endpoint.outbound.id
}

output "outbound_endpoint_ips" {
  value = data.aws_route53_resolver_endpoint.outbound.ip_addresses
}
