# Copyright Amazon.com, Inc. or its affiliates. All rights reserved.
# SPDX-License-Identifier: Apache-2.0

module "prod" {
  source = "../aft-account-request"

  control_tower_parameters = {
    AccountEmail              = replace("${var.common_parameters.account_email}", "@", "+prod@")
    AccountName               = upper("${var.common_parameters.app_name}-PROD")
    ManagedOrganizationalUnit = "Production"
    SSOUserEmail              = "default_sso_user@email.com"
    SSOUserFirstName          = "AWS Control Tower"
    SSOUserLastName           = "Admin"
  }

  account_tags = merge(
    { "environment" = "prod" },
    var.common_parameters.account_tags
  )

  change_management_parameters = var.common_parameters.change_management_parameters

  custom_fields = {
    regions  = jsonencode(["primary", "secondary"])
    phz_name = "${var.common_parameters.app_name}.prod.on.aws"
    vpc = jsonencode({
      identifier  = var.common_parameters.app_name
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

module "stage" {
  source = "../aft-account-request"

  control_tower_parameters = {
    AccountEmail              = replace("${var.common_parameters.account_email}", "@", "+stage@")
    AccountName               = upper("${var.common_parameters.app_name}-STAGE")
    ManagedOrganizationalUnit = "Staging"
    SSOUserEmail              = "default_sso_user@email.com"
    SSOUserFirstName          = "AWS Control Tower"
    SSOUserLastName           = "Admin"
  }

  account_tags = merge(
    { "environment" = "stage" },
    var.common_parameters.account_tags
  )

  change_management_parameters = var.common_parameters.change_management_parameters

  custom_fields = {
    regions  = jsonencode(["primary", "secondary"])
    phz_name = "${var.common_parameters.app_name}.stage.on.aws"
    vpc = jsonencode({
      identifier  = var.common_parameters.app_name
      environment = "stage"
      vpc_size    = "medium"
    })
    tags = jsonencode({
      env = "stage"
    })
    ou = "Staging"
  }

  account_customizations_name = "APP_STAGE"
}

module "dev" {
  source = "../aft-account-request"

  control_tower_parameters = {
    AccountEmail              = replace("${var.common_parameters.account_email}", "@", "+dev@")
    AccountName               = upper("${var.common_parameters.app_name}-DEV")
    ManagedOrganizationalUnit = "Development"
    SSOUserEmail              = "default_sso_user@email.com"
    SSOUserFirstName          = "AWS Control Tower"
    SSOUserLastName           = "Admin"
  }

  account_tags = merge(
    { "environment" = "dev" },
    var.common_parameters.account_tags
  )

  change_management_parameters = var.common_parameters.change_management_parameters

  custom_fields = {
    regions  = jsonencode(["primary", "secondary"])
    phz_name = "${var.common_parameters.app_name}.dev.on.aws"
    vpc = jsonencode({
      identifier  = var.common_parameters.app_name
      environment = "dev"
      vpc_size    = "medium"
    })
    tags = jsonencode({
      env = "dev"
    })
    ou = "Development"
  }

  account_customizations_name = "APP_DEV"
}

module "devops" {
  source = "../aft-account-request"

  control_tower_parameters = {
    AccountEmail              = replace("${var.common_parameters.account_email}", "@", "+devops@")
    AccountName               = upper("${var.common_parameters.app_name}-DEVOPS")
    ManagedOrganizationalUnit = "Deployment"
    SSOUserEmail              = "default_sso_user@email.com"
    SSOUserFirstName          = "AWS Control Tower"
    SSOUserLastName           = "Admin"
  }

  account_tags = merge(
    { "environment" = "shared" },
    var.common_parameters.account_tags
  )

  change_management_parameters = var.common_parameters.change_management_parameters

  custom_fields = {
    regions = jsonencode(["primary"])
    tags = jsonencode({
      env = "shared"
    })
    ou = "Deployment"
  }

  account_customizations_name = "DEVOPS"
}
