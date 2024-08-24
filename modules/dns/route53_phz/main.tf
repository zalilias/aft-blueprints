# Copyright Amazon.com, Inc. or its affiliates. All rights reserved.
# SPDX-License-Identifier: Apache-2.0

resource "aws_route53_zone" "this" {
  #checkov:skip=CKV2_AWS_38:DNSSEC is not applied to private hosted zones.
  #checkov:skip=CKV2_AWS_39:No log strategy has been defined for private DNS zones.
  name          = var.name
  force_destroy = var.force_destroy
  vpc {
    vpc_id = var.vpc_id
  }
  tags = merge(
    { "Name" = var.name },
    var.tags
  )
  lifecycle {
    ignore_changes = [vpc]
  }
}

resource "aws_route53_zone_association" "this" {
  for_each = var.add_vpc

  zone_id    = aws_route53_zone.this.zone_id
  vpc_id     = each.value.vpc_id
  vpc_region = each.value.region
}
