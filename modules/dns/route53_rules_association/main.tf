# Copyright Amazon.com, Inc. or its affiliates. All rights reserved.
# SPDX-License-Identifier: Apache-2.0

resource "aws_route53_resolver_rule_association" "this" {
  for_each = data.aws_route53_resolver_rules.shared_resolvers.resolver_rule_ids

  resolver_rule_id = each.value
  vpc_id           = var.vpc_id
}
