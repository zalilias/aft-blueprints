# Copyright Amazon.com, Inc. or its affiliates. All rights reserved.
# SPDX-License-Identifier: Apache-2.0

output "route53_resolver_endpoint_inbound" {
  value = aws_route53_resolver_endpoint.inbound
}

output "route53_resolver_endpoint_outbound" {
  value = aws_route53_resolver_endpoint.outbound
}

output "route53_resolver_rule_fwd_to_domain" {
  value = aws_route53_resolver_rule.forward
}
