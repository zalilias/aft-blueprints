# Copyright Amazon.com, Inc. or its affiliates. All rights reserved.
# SPDX-License-Identifier: Apache-2.0

data "aws_ssm_parameter" "network_account_id" {
  provider = aws.aft-management
  name     = "/org/core/accounts/network"
}
