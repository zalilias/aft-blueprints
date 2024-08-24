# Copyright Amazon.com, Inc. or its affiliates. All rights reserved.
# SPDX-License-Identifier: Apache-2.0

output "zone_id" {
  value       = aws_route53_zone.this.zone_id
  description = "The hosted zone id"
}
