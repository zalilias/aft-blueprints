# Copyright Amazon.com, Inc. or its affiliates. All rights reserved.
# SPDX-License-Identifier: Apache-2.0

########################################
#######   AFT Core Parameters    #######
########################################
resource "aws_ssm_parameter" "account_id" {
  # checkov:skip=CKV_AWS_33var.min_retention_days:This SSM parameter is not a SecureString and there is no need to encrypt it using KMS
  provider = aws.aft-management

  name        = "/org/core/accounts/backup"
  type        = "String"
  description = "Delegated AWS Backup account Id"
  value       = data.aws_caller_identity.current.account_id
  tags        = local.tags
}

########################################
####### AWS Backup Configuration #######
########################################

resource "aws_backup_global_settings" "backup" {
  provider = aws.org-management

  global_settings = {
    "isCrossAccountBackupEnabled" = "true"
  }
}

resource "aws_organizations_delegated_administrator" "backup" {
  provider   = aws.org-management
  depends_on = [aws_backup_global_settings.backup]

  account_id        = data.aws_caller_identity.current.account_id
  service_principal = "backup.amazonaws.com"
}


########################################
#######   AWS Backup Resources   #######
########################################
module "aws_backup_primary" {
  source = "../../common/modules/backup/central_vault"
  providers = {
    aws = aws.primary
  }
  depends_on = [aws_organizations_delegated_administrator.backup]

  backup_vault_name        = var.backup_vault_name
  enable_backup_vault_lock = var.enable_backup_vault_lock
  backup_vault_lock_config = {
    min_retention_days  = var.backup_vault_lock_min_retention_days
    max_retention_days  = var.backup_vault_lock_max_retention_days
    changeable_for_days = var.backup_vault_lock_changeable_for_days
  }
  create_backup_roles = true
  tags                = local.tags
}

module "opt_in_services_primary" {
  source = "../../common/modules/backup/opt_in_services"
  providers = {
    aws = aws.org-management-primary
  }
  depends_on = [
    module.aws_backup_primary
  ]

  opt_in_services = {
    "Aurora"                 = true
    "DocumentDB"             = true
    "DynamoDB"               = true
    "EBS"                    = true
    "EC2"                    = true
    "EFS"                    = true
    "FSx"                    = true
    "Neptune"                = true
    "RDS"                    = true
    "Storage Gateway"        = true
    "VirtualMachine"         = true
    "Redshift"               = true
    "CloudFormation"         = true
    "S3"                     = true
    "Timestream"             = true
    "SAP HANA on Amazon EC2" = false
  }
  advanced_features = {
    "DynamoDB" = true
    "EFS"      = true
  }
  tags = local.tags
}

module "aws_backup_secondary" {
  source = "../../common/modules/backup/central_vault"
  providers = {
    aws = aws.secondary
  }
  depends_on = [aws_organizations_delegated_administrator.backup]

  backup_vault_name        = var.backup_vault_name
  enable_backup_vault_lock = var.enable_backup_vault_lock
  backup_vault_lock_config = {
    min_retention_days  = var.backup_vault_lock_min_retention_days
    max_retention_days  = var.backup_vault_lock_max_retention_days
    changeable_for_days = var.backup_vault_lock_changeable_for_days
  }
  create_backup_roles = false
  tags                = local.tags
}

module "opt_in_services_secondary" {
  source = "../../common/modules/backup/opt_in_services"
  providers = {
    aws = aws.org-management-secondary
  }
  depends_on = [
    module.aws_backup_secondary
  ]

  opt_in_services = {
    "Aurora"                 = true
    "DocumentDB"             = true
    "DynamoDB"               = true
    "EBS"                    = true
    "EC2"                    = true
    "EFS"                    = true
    "FSx"                    = true
    "Neptune"                = true
    "RDS"                    = true
    "Storage Gateway"        = true
    "VirtualMachine"         = true
    "Redshift"               = true
    "CloudFormation"         = true
    "S3"                     = true
    "Timestream"             = true
    "SAP HANA on Amazon EC2" = false
  }
  advanced_features = {
    "DynamoDB" = true
    "EFS"      = true
  }
  tags = local.tags
}

########################################
#######     AWS Backup Report    #######
########################################
module "aws_backup_report" {
  source = "../../common/modules/backup/backup_report"
  providers = {
    aws = aws.primary
  }

  depends_on = [
    module.aws_backup_primary,
    module.aws_backup_secondary
  ]

  report_s3_bucket_name             = "aws-backup-reports-${data.aws_caller_identity.current.account_id}-${data.aws_region.primary.name}"
  enable_backup_jobs_report         = var.enable_backup_jobs_report
  enable_backup_copy_jobs_report    = var.enable_backup_copy_jobs_report
  enable_backup_restore_jobs_report = var.enable_backup_restore_jobs_report
  report_regions = [
    data.aws_region.primary.name,
    data.aws_region.secondary.name,
  ]
  tags = local.tags
}
