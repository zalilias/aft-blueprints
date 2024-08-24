# SecurityHub Account Configuration - Terraform Module

This module is used to configure SecurityHub standards and control exceptions in an AWS Account. As the Security Hub delegated administrator does not centrally push configurations to the member accounts, each member account will require to be configured. We recommended to uniformly configure Security Hub across all accounts through the Global Configurations.

This configuration is regional so the module will be used multiple times with references to the terraform providers for the relevant regions.

The modules takes 2 inputs:
- List of SecurityHub Standards ARNs to enable.
- List of Control Exception to configure. This requires 3 inputs per control
  - Name.
  - Status.
  - Reason for exception.

## Assumptions
- Account Factory for Terraform is used or a repository and/or TF workspace is setup for AWS Account
- Ability to configure terraform providers for multiple regions

## Usage
To use the module with AFT, add the module directory to the aft-global-customizations modules directory. Then add module resources in the main.tf or new tf file under the terraform directory.

Enable the Foundational Security Best Practices Standard with no exceptions:
```
module "securityhub_acctconfig_us-east-1" {
  source             = "./modules/securityhub"
  enable_standards   = [
    "arn:aws:securityhub:<region>::standards/aws-foundational-security-best-practices/v/1.0.0"
  ]
  providers = {
    aws = aws.us-east-1
  }
}
```

Enable multiple Standards, and provide and exception:
```
module "securityhub_acctconfig_us-east-1" {
  source             = "./modules/securityhub"
  enable_standards   = [
    "arn:aws:securityhub:<region>::standards/aws-foundational-security-best-practices/v/1.0.0",
    "arn:aws:securityhub:::ruleset/cis-aws-foundations-benchmark/v/1.2.0"
  ]
  control_exceptions = [
    {
      name    = "aws-foundational-security-best-practices/v/1.0.0/IAM.6"
      status  = "DISABLED"
      reason  = "No root MFA. SCP prevents root action"
    }
  ]
  providers = {
    aws = aws.us-east-1
  }
}
```

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.20.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_securityhub_standards_control.control](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/securityhub_standards_control) | resource |
| [aws_securityhub_standards_subscription.standard](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/securityhub_standards_subscription) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_control_exceptions"></a> [control\_exceptions](#input\_control\_exceptions) | List of Security Hub Checks to enable/disable | <pre>list(object({<br>    name   = string<br>    status = string<br>    reason = string<br>  }))</pre> | `[]` | no |
| <a name="input_enable_standards"></a> [enable\_standards](#input\_enable\_standards) | List of Security Hub Standards to enable | `list(string)` | `[]` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
