# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
# SPDX-License-Identifier: Apache-2.0

locals {
  region                          = data.aws_region.current.name
  attachment_name                 = "${data.aws_caller_identity.current.account_id}-tgw-attach-${var.vpc_name}"
  use_propagation_rules_parameter = length(var.tgw_rt_propagations) == 0 ? true : false
  tgw_rt_propagations             = local.use_propagation_rules_parameter ? try(jsondecode(data.aws_ssm_parameter.propagation_rules[0].insecure_value)[var.tgw_rt_association_name], []) : var.tgw_rt_propagations
  use_association_parameter       = var.tgw_rt_association_name != "" ? true : false
  tgw_rt_association              = local.use_association_parameter ? try(data.aws_ssm_parameter.rt_association[0].insecure_value, "") : var.tgw_rt_association_id
  tgw_id                          = var.tgw_id == "" ? data.aws_ssm_parameter.tgw_id[0].insecure_value : var.tgw_id
}
