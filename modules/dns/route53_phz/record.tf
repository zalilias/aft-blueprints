# Copyright Amazon.com, Inc. or its affiliates. All rights reserved.
# SPDX-License-Identifier: Apache-2.0

resource "random_integer" "value" {
  count = var.create_test_record ? 1 : 0

  min = 10
  max = 99
}

resource "aws_route53_record" "test" {
  #checkov:skip=CKV2_AWS_23:This is just a test record for private hosted zones.
  count = var.create_test_record ? 1 : 0

  zone_id = aws_route53_zone.this.zone_id
  name    = "test.${var.name}"
  type    = "A"
  ttl     = 300
  records = ["10.10.10.${random_integer.value[0].result}"]
}
