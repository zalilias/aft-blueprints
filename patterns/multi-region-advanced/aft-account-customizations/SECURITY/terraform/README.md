# Security Tooling Customization - Multi Region Advanced

## How to use

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >=1.5.0 |

## Providers

| Name | Version |
|------|---------|
| aws | 5.70.0 |
| aws.aft-management | 5.70.0 |
| aws.org-management-primary | 5.70.0 |
| aws.org-management-secondary | 5.70.0 |
| aws.primary | 5.70.0 |
| aws.secondary | 5.70.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| aft\_custom\_fields | ../../common/modules/custom_fields | n/a |
| primary\_guardduty | ../../common/modules/security/guardduty | n/a |
| secondary\_guardduty | ../../common/modules/security/guardduty | n/a |
| securityhub | ../../common/modules/security/securityhub | n/a |
| securityhub\_default\_policy | ../../common/modules/security/securityhub_policy | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_guardduty_organization_admin_account.primary](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/guardduty_organization_admin_account) | resource |
| [aws_guardduty_organization_admin_account.secondary](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/guardduty_organization_admin_account) | resource |
| [aws_securityhub_account.primary](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/securityhub_account) | resource |
| [aws_securityhub_account.secondary](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/securityhub_account) | resource |
| [aws_securityhub_organization_admin_account.securityhub](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/securityhub_organization_admin_account) | resource |
| [aws_ssm_parameter.account_id](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_organizations_organization.org](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/organizations_organization) | data source |
| [aws_region.secondary](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| guardduty\_auto\_enable\_organization\_members | Define whether enable GuardDuty Organization Configuration or not. | `string` | `"ALL"` | no |
| securityhub\_control\_finding\_generator | Define whether the Security Hub calling account has consolidated control findings turned on. | `string` | `"SECURITY_CONTROL"` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->