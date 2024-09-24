# Centralized AWS Backup Customization - Multi Region Advanced

This Terraform code is designed to configure the AWS Backup service to provide a centralized backup architecture in a multi-account environment.

The following resources will be deployed by this solution (not limited to those below):

- A centralized AWS Backup Vault
- An AWS Backup Vault policy allowing cross-account access
- An AWS Backup Vault Lock configuration
- AWS KMS Key allowing cross-account access
- AWS IAM Role for backup service

For more information, see the [Centralized AWS Backup](../../docs/architectures/aws-backup.md){:target="_blank"} architecture page.

## How to use

Define the regions you want to use in the `aft-config.j2` file:

```json
{% 
  set regions = [
    {
      "key": "primary",
      "name": "us-east-1"
    },
    {
      "key": "secondary",
      "name": "us-west-2"
    }
  ]
%}
```

<!-- 
Update the `variable.auto.tfvars` file with the corresponding values for:

### AWS Backup Vault

### AWS Backup Opt-In Services 

### AWS Backup Report
-->

This customizations enables the AWS Backup cross-account management feature. However, if you want to manage backup policies through AWS Organizations in a centralized place, we recommend you to delegate AWS Backup policies to the backup account after launching the it and applying the customization. Check out the [Managing AWS Backup resources across multiple AWS accounts](https://docs.aws.amazon.com/aws-backup/latest/devguide/manage-cross-account.html) documentation, more specifically in the section **Delegate AWS Backup policies through AWS Organizations**.

See below an example of an AWS Organizations delegation policy. Replace the placeholders `BACKUP-ACCOUNT-ID` and `ORG-MANAGEMENT-ACCOUNT-ID` with your own values.

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "AllowOrganizationsRead",
      "Effect": "Allow",
      "Principal": {
        "AWS": "arn:aws:iam::{{ BACKUP-ACCOUNT-ID }}:root"
      },
      "Action": [
        "organizations:Describe*",
        "organizations:List*"
      ],
      "Resource": [
        "arn:aws:organizations::{{ ORG-MANAGEMENT-ACCOUNT-ID }}:root/*",
        "arn:aws:organizations::{{ ORG-MANAGEMENT-ACCOUNT-ID }}:ou/*",
        "arn:aws:organizations::{{ ORG-MANAGEMENT-ACCOUNT-ID }}:account/*"
      ]
    },
    {
      "Sid": "AllowBackupPoliciesManagement",
      "Effect": "Allow",
      "Principal": {
        "AWS": "arn:aws:iam::{{ BACKUP-ACCOUNT-ID }}:root"
      },
      "Action": [
        "organizations:List*",
        "organizations:Describe*",
        "organizations:CreatePolicy",
        "organizations:UpdatePolicy",
        "organizations:DeletePolicy"
      ],
      "Resource": "*",
      "Condition": {
        "StringEquals": {
          "organizations:PolicyType": "BACKUP_POLICY"
        }
      }
    },
    {
      "Sid": "AllowBackupPoliciesAttachmentAndDetachmentToAllAccountsAndOUs",
      "Effect": "Allow",
      "Principal": {
        "AWS": "arn:aws:iam::{{ BACKUP-ACCOUNT-ID }}:root"
      },
      "Action": [
        "organizations:AttachPolicy",
        "organizations:DetachPolicy"
      ],
      "Resource": [
        "arn:aws:organizations::{{ ORG-MANAGEMENT-ACCOUNT-ID }}:root/*",
        "arn:aws:organizations::{{ ORG-MANAGEMENT-ACCOUNT-ID }}:ou/*",
        "arn:aws:organizations::{{ ORG-MANAGEMENT-ACCOUNT-ID }}:account/*",
        "arn:aws:organizations::{{ ORG-MANAGEMENT-ACCOUNT-ID }}:policy/*/backup_policy/*"        
      ],
      "Condition": {
        "StringEquals": {
          "organizations:PolicyType": "BACKUP_POLICY"
        }
      }
    }
  ]
}
```

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >=1.5.0 |

## Providers

| Name | Version |
|------|---------|
| aws | 5.45.0 |
| aws.aft-management | 5.45.0 |
| aws.org-management | 5.45.0 |
| aws.primary | 5.45.0 |
| aws.secondary | 5.45.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| aft\_custom\_fields | ../../common/modules/custom_fields | n/a |
| aws\_backup\_primary | ../../common/modules/backup/central_vault | n/a |
| aws\_backup\_report | ../../common/modules/backup/backup_report | n/a |
| aws\_backup\_secondary | ../../common/modules/backup/central_vault | n/a |
| opt\_in\_services\_primary | ../../common/modules/backup/opt_in_services | n/a |
| opt\_in\_services\_secondary | ../../common/modules/backup/opt_in_services | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_backup_global_settings.backup](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/backup_global_settings) | resource |
| [aws_organizations_delegated_administrator.backup](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/organizations_delegated_administrator) | resource |
| [aws_ssm_parameter.account_id](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_organizations_organization.org](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/organizations_organization) | data source |
| [aws_region.primary](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |
| [aws_region.secondary](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

No inputs.

## Outputs

No outputs.
<!-- END_TF_DOCS -->