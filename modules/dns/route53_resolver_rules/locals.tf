# Copyright Amazon.com, Inc. or its affiliates. All rights reserved.
# SPDX-License-Identifier: Apache-2.0

locals {
  rules = {
    for k, v in var.rules : k => {
      rule_name          = v.rule_name == null ? replace(v.domain_name, ".", "-") : v.rule_name
      rule_type          = v.rule_type == null ? "FORWARD" : v.rule_type
      resource_share_arn = v.resource_share_arn == null ? data.aws_organizations_organization.org.arn : v.resource_share_arn
      associate_to_vpc   = v.associate_to_vpc == null ? false : v.associate_to_vpc
      target_ips         = v.target_ips == null ? var.resolver_target_ips : v.target_ips
      domain_name        = v.domain_name
    }
  }
}
