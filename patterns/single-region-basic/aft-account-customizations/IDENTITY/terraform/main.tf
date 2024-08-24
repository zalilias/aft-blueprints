# Copyright Amazon.com, Inc. or its affiliates. All rights reserved.
# SPDX-License-Identifier: Apache-2.0

########################################
#######   AFT Core Parameters    #######
########################################
resource "aws_ssm_parameter" "account_id" {
  # checkov:skip=CKV_AWS_337:This SSM parameter is not a SecureString and there is no need to encrypt it using KMS
  provider = aws.aft-management

  name        = "/org/core/accounts/identity"
  type        = "String"
  description = "Delegated IAM Identity Center account Id"
  value       = data.aws_caller_identity.current.account_id
  tags        = local.tags
}

############################################
#######  Identity Center Delegation  #######
############################################
resource "aws_organizations_delegated_administrator" "sso" {
  provider = aws.org-management

  account_id        = data.aws_caller_identity.current.account_id
  service_principal = "sso.amazonaws.com"
}

########################################
#######    Pipeline Resources    #######
########################################
module "aws_ps_pipeline" {
  source = "./modules/aws-ps-pipeline"
  providers = {
    aws.org-management = aws.org-management
    aws.aft-management = aws.aft-management
  }
  depends_on = [aws_organizations_delegated_administrator.sso]

  #use_control_tower_events = true
  repository_name          = "aws-ps-pipeline"
  main_branch_name         = "main"
  test_branch_name         = "dev"
  tags                     = local.tags
}


########################################
#######    Pipeline Resources    #######
########################################
# module "iam_access_analyzer" {
#   source = "./modules/iam-access-analyzer"

#   name = "iam-org-access-analyzer"
#   type = "ORGANIZATION"
# }
