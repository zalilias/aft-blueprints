# Copyright Amazon.com, Inc. or its affiliates. All rights reserved.
# SPDX-License-Identifier: Apache-2.0

data "aws_ec2_transit_gateway_dx_gateway_attachment" "this" {
  depends_on = [
    aws_dx_gateway_association.this
  ]
  transit_gateway_id = var.associated_gateway_id
  dx_gateway_id      = var.dx_gateway_id
}
