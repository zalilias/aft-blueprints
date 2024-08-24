# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
# SPDX-License-Identifier: Apache-2.0

data "aws_region" "current" {}

data "aws_caller_identity" "network" {
  provider = aws.network
}

data "aws_caller_identity" "current" {}

data "aws_ssm_parameter" "tgw_id" {
  count    = var.tgw_id == "" ? 1 : 0
  provider = aws.network

  name = "/org/core/network/tgw-id"
}

data "aws_ssm_parameter" "propagation_rules" {
  count    = local.use_propagation_rules_parameter ? 1 : 0
  provider = aws.network

  name = "/org/core/network/tgw-propagation-rules"
}

data "aws_ssm_parameter" "rt_association" {
  count    = local.use_association_parameter ? 1 : 0
  provider = aws.network

  name = "/org/core/network/tgw-route-table/${var.tgw_rt_association_name}"
}

data "aws_ssm_parameter" "rt_propagations" {
  for_each = toset(local.tgw_rt_propagations)
  provider = aws.network

  name = "/org/core/network/tgw-route-table/${each.value}"
}
