# Copyright Amazon.com, Inc. or its affiliates. All rights reserved.
# SPDX-License-Identifier: Apache-2.0

output "attachment_id" {
  value = data.aws_ec2_transit_gateway_dx_gateway_attachment.this.id
}
