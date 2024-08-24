# Copyright Amazon.com, Inc. or its affiliates. All rights reserved.
# SPDX-License-Identifier: Apache-2.0

locals {
  rules = [
    for rule in var.rules : {
      rule_name        = replace(rule.domain_name, ".", "-")
      domain_name      = rule.domain_name
      target_ip        = length(rule.external_dns_ips) > 0 ? rule.external_dns_ips : aws_route53_resolver_endpoint.inbound.ip_address[*].ip
      associate_to_vpc = length(rule.external_dns_ips) > 0 ? true : false
    }
  ]
}
