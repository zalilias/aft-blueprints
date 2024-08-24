# Copyright Amazon.com, Inc. or its affiliates. All rights reserved.
# SPDX-License-Identifier: Apache-2.0

module "myapp" {
  source = "./modules/aft-account-combo"

  common_parameters = {
    app_name      = "myapp"
    account_email = "aws-myapp@email.com"
    account_tags = {
      owner = "vinelias"
    }
    change_management_parameters = {
      change_requested_by = "vinelias"
      change_reason       = "Testing the account combo"
    }
  }
}
