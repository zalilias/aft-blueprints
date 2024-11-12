# Copyright Amazon.com, Inc. or its affiliates. All rights reserved.
# SPDX-License-Identifier: Apache-2.0

locals {
  event_rule_account_id = var.account_lifecycle_events_source == "CT" ? data.aws_organizations_organization.org[0].master_account_id : (var.account_lifecycle_events_source == "AFT" ? data.aws_ssm_parameter.aft_management_account_id[0].value : null)
}
