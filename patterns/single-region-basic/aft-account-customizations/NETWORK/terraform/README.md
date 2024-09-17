<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >=1.5.0 |

## Providers

| Name | Version |
|------|---------|
| aws | 5.42.0 |
| aws.aft-management | 5.42.0 |
| aws.org-management | 5.42.0 |
| aws.primary | 5.42.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| aft\_custom\_fields | ../../common/modules/custom_fields | n/a |
| ipam | aws-ia/ipam/aws | 2.1.0 |
| primary\_region | ./modules/region | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_ram_sharing_with_organization.ram](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ram_sharing_with_organization) | resource |
| [aws_ssm_parameter.account_id](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter) | resource |
| [aws_vpc_ipam_organization_admin_account.ipam](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_ipam_organization_admin_account) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_organizations_organization.org](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/organizations_organization) | data source |
| [aws_region.primary](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| aws\_availability\_zones | "Map of availability zones allowed to be used in this region." Example: ```aws_availability_zones = { primary_region = { az1 = "us-east-1a" az2 = "us-east-1b" } secondary_region = { az1 = "us-west-2a" az2 = "us-west-2b" } }``` | `map(any)` | n/a | yes |
| aws\_ip\_address\_plan | "Object with IP address plan which defines the CIDR blocks to be used in AWS regions." Example: ```aws_ip_address_plan = { global_cidr_blocks = ["10.10.0.0/16","10.20.0.0/16"] primary_region = { cidr_blocks = ["10.10.0.0/16"] shared = { cidr_blocks = ["10.10.0.0/18"] } prod = { cidr_blocks = ["10.10.64.0/18"] } stage = { cidr_blocks = ["10.10.128.0/18"] } dev = { cidr_blocks = ["10.10.192.0/18"] } } }``` | ```object({ global_cidr_blocks = list(string) primary_region = object({ cidr_blocks = list(string) shared = object({ cidr_blocks = list(string) }) prod = object({ cidr_blocks = list(string) }) stage = object({ cidr_blocks = list(string) }) dev = object({ cidr_blocks = list(string) }) }) })``` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->