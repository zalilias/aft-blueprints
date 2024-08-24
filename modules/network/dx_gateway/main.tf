# Copyright Amazon.com, Inc. or its affiliates. All rights reserved.
# SPDX-License-Identifier: Apache-2.0

resource "aws_dx_gateway" "this" {
  name            = var.gateway_name
  amazon_side_asn = var.bgp_asn
}
