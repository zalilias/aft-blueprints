# Copyright Amazon.com, Inc. or its affiliates. All rights reserved.
# SPDX-License-Identifier: Apache-2.0
#
module "production" {
  source = "./modules/aft-account-request"

  control_tower_parameters = {
    AccountEmail = "vinelias+cfa-production@amazon.com"
    AccountName  = "CFA-Production"
    # Syntax for top-level OU
    ManagedOrganizationalUnit = "Production"
    # Syntax for nested OU
    # ManagedOrganizationalUnit = "Sandbox (ou-xfe5-a8hb8ml8)"
    SSOUserEmail     = "vinelias+cfa@amazon.com"
    SSOUserFirstName = "AWS Control Tower"
    SSOUserLastName  = "Admin"
  }

  account_tags = {
    owner       = "vinelias"
    environment = "production"
  }

  change_management_parameters = {
    change_requested_by = "vinelias"
    change_reason       = "Testing the account vending process"
  }

  custom_fields = {
    regions  = jsonencode(["primary", "secondary"])
    phz_name = "myapp.prod.on.aws"
    vpc = jsonencode({
      identifier  = "payment"
      environment = "prod"
      vpc_size    = "medium"
    })
    tags = jsonencode({
      env = "prod"
    })
    ou = "Production"
  }

  account_customizations_name = "APP_PROD"
}
