# Copyright Amazon.com, Inc. or its affiliates. All rights reserved.
# SPDX-License-Identifier: Apache-2.0

resource "aws_route53_vpc_association_authorization" "authorization" {
  for_each = { for vpc in data.aws_vpcs.this.ids : vpc => vpc }

  vpc_id     = each.value
  zone_id    = var.phz_id
  vpc_region = data.aws_region.dns.name
}

resource "aws_route53_zone_association" "association" {
  for_each   = { for vpc in data.aws_vpcs.this.ids : vpc => vpc }
  depends_on = [aws_route53_vpc_association_authorization.authorization]
  provider   = aws.dns

  vpc_id     = each.value
  zone_id    = var.phz_id
  vpc_region = data.aws_region.dns.name
}
