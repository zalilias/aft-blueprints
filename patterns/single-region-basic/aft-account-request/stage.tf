# Copyright Amazon.com, Inc. or its affiliates. All rights reserved.
# SPDX-License-Identifier: Apache-2.0
#
module "stage" {
  source = "./modules/aft-account-request"

  control_tower_parameters = {
    AccountEmail = "vinelias+cfa-stage@amazon.com"
    AccountName  = "CFA-Stage"
    # Syntax for top-level OU
    ManagedOrganizationalUnit = "Staging"
    # Syntax for nested OU
    # ManagedOrganizationalUnit = "Sandbox (ou-xfe5-a8hb8ml8)"
    SSOUserEmail     = "vinelias+cfa@amazon.com"
    SSOUserFirstName = "AWS Control Tower"
    SSOUserLastName  = "Admin"
  }

  account_tags = {
    owner = "vinelias"
  }

  change_management_parameters = {
    change_requested_by = "vinelias"
    change_reason       = "Testing the account vending process"
  }

  custom_fields = {
    regions  = jsonencode(["primary"])
    phz_name = "myapp.stage.on.aws"
    vpc = jsonencode({
      identifier  = "payment"
      environment = "stage"
      vpc_size    = "small"
    })
    tags = jsonencode({
      env = "stage"
    })
    ou = "Staging"
  }

  account_customizations_name = "APP_PROD"
}
