# Copyright Amazon.com, Inc. or its affiliates. All rights reserved.
# SPDX-License-Identifier: Apache-2.0

locals {
  event_rule_account_id = var.use_control_tower_events ? data.aws_organizations_organization.org.master_account_id : data.aws_ssm_parameter.aft_management_account_id[0].value
}