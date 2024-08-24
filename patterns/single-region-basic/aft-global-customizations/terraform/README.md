# Global Customizations - IAM Password Policy

This is an example of configuring an IAM Password Policy using AFT Global Customizations. As this is a
single Terraform resource, and is only required once per AWS Account. We can place the code in the main.tf
file in aft-global-customizations.

It is highly recommended from AWS Secuyrity Best Practices that a strong password policy be set for any IAM
based users.

## Assumptions

- Account Factory for Terraform is used or a repository and/or TF workspace is setup for AWS Account.

## References

- Terraform Docs: [iam_account_password_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_account_password_policy)
