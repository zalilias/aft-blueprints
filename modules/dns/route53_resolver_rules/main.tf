# Copyright Amazon.com, Inc. or its affiliates. All rights reserved.
# SPDX-License-Identifier: Apache-2.0

resource "aws_route53_resolver_rule" "this" {
  for_each = local.rules

  domain_name          = each.value.domain_name
  name                 = each.value.rule_name
  rule_type            = each.value.rule_type
  resolver_endpoint_id = var.resolver_endpoint_id

  dynamic "target_ip" {
    for_each = toset([for ip in each.value.target_ips : ip if each.value.rule_type == "FORWARD"])
    content {
      ip = target_ip.value
    }
  }

  tags = merge(
    { Name = each.value.rule_name },
    var.tags
  )
}

resource "aws_route53_resolver_rule_association" "this" {
  for_each = { for k, v in local.rules : k => v if v.associate_to_vpc }

  resolver_rule_id = aws_route53_resolver_rule.this[each.key].id
  vpc_id           = var.vpc_id
}

resource "aws_ram_resource_share" "this" {
  for_each = local.rules

  name                      = "r53-rr-${each.value.rule_name}"
  allow_external_principals = false
  tags                      = var.tags
}

resource "aws_ram_principal_association" "this" {
  for_each = local.rules

  principal          = each.value.resource_share_arn
  resource_share_arn = aws_ram_resource_share.this[each.key].arn
}

resource "aws_ram_resource_association" "this" {
  for_each = local.rules

  resource_arn       = aws_route53_resolver_rule.this[each.key].arn
  resource_share_arn = aws_ram_resource_share.this[each.key].arn
}
