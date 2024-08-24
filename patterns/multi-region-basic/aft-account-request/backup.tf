# Copyright Amazon.com, Inc. or its affiliates. All rights reserved.
# SPDX-License-Identifier: Apache-2.0

module "backup" {
  source = "./modules/aft-account-request"

  control_tower_parameters = {
    AccountEmail = "vinelias+cfa-backup@amazon.com"
    AccountName  = "CFA-Backup"
    # Syntax for top-level OU
    ManagedOrganizationalUnit = "Infrastructure"
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
    tags = jsonencode({
      env = "shared"
    })
  }

  account_customizations_name = "BACKUP"
}
