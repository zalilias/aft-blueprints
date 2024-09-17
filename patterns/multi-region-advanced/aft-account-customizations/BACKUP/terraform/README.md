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