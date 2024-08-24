<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >=1.5.0 |
| aws | >=5.0.0 |

## Providers

| Name | Version |
|------|---------|
| aws | >=5.0.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_security_group.endpoints](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_vpc_endpoint.gateway](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint) | resource |
| [aws_vpc_endpoint.interface](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint) | resource |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| allowed\_cidr | n/a | `list(string)` | n/a | yes |
| gateway\_endpoints | A list of route tables and gateway endpoints | ```object({ route_table_ids = list(string) services = list(string) })``` | ```{ "route_table_ids": [], "services": [] }``` | no |
| interface\_endpoints | A list of subnets and interface endpoints | ```object({ subnet_ids = list(string) services = list(string) })``` | ```{ "services": [], "subnet_ids": [] }``` | no |
| tags | n/a | `map(string)` | `{}` | no |
| vpc\_id | n/a | `string` | n/a | yes |
| vpc\_name | n/a | `string` | `""` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->