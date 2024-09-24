# Identity Management Customization - Multi Region Basic

This Terraform code is designed to set up an identity management pipeline for AWS IAM Identity Center, providing an automated and dynamic way to manage Permission Sets in a multi-account environment. IAM Access Analyzer is also set up to perform external access analysis at the organization level.

The following resources will be deployed by this solution (not limited to those below):

- AWS CodePipeline
- AWS CodBuild
- Amazon EventBridge Rule
- AWS S3 Bucket
- AWS DynamoDB Table
- AWS IAM Access Analyzer

For more information, see the [Identity Management](https://awslabs.github.io/aft-blueprints/architectures/identity-management) architecture page.

## How to use

Define the regions you want to use in the `aft-config.j2` file:

```jinja
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

### AWS Permission Set Pipeline

### AWS IAM Access Analyzer
-->

After you have launched the account and deployed the pipeline, you must copy the contents of the [`assets/source/aws-ps-pipeline`](https://github.com/awslabs/aft-blueprints/tree/main/assets/source/aws-ps-pipeline) directory to the repository associated with the pipeline (AWS CodeCommit or GitHub). There you will find the Terraform files used to run the public module ["permission-sets"](https://registry.terraform.io/modules/aws-ia/permission-sets/aws/latest) and apply a sample permission set defined in the `templates` directory.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >=1.5.0 |

## Providers

| Name | Version |
|------|---------|
| aws | 5.44.0 |
| aws.aft-management | 5.44.0 |
| aws.org-management | 5.44.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| aft\_custom\_fields | ../../common/modules/custom_fields | n/a |
| aws\_ps\_pipeline | ./modules/aws-ps-pipeline | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_organizations_delegated_administrator.sso](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/organizations_delegated_administrator) | resource |
| [aws_ssm_parameter.account_id](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_organizations_organization.org](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/organizations_organization) | data source |

## Inputs

No inputs.

## Outputs

No outputs.
<!-- END_TF_DOCS -->