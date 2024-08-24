# Copyright Amazon.com, Inc. or its affiliates. All rights reserved.
# SPDX-License-Identifier: Apache-2.0

resource "aws_ec2_transit_gateway_route_table" "this" {
  transit_gateway_id = var.transit_gateway_id
  tags = merge(
    { "Name" = "tgw-rtb-${var.route_table_name}" },
    var.tags
  )
}

resource "aws_ssm_parameter" "tgw_route_table" {
  # checkov:skip=CKV_AWS_337:This SSM parameter is not a SecureString and there is no need to encrypt it using KMS
  name        = "/org/core/network/tgw-route-table/${var.route_table_name}"
  type        = "String"
  description = "Transit Gateway route table ${var.route_table_name} Id"
  value       = aws_ec2_transit_gateway_route_table.this.id
}

