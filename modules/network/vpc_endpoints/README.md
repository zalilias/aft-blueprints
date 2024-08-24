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
| [aws_default_network_acl.default_acl](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/default_network_acl) | resource |
| [aws_default_route_table.default_rtb](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/default_route_table) | resource |
| [aws_default_security_group.default_sgp](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/default_security_group) | resource |
| [aws_ec2_transit_gateway_route_table_association.tgw](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_transit_gateway_route_table_association) | resource |
| [aws_ec2_transit_gateway_route_table_propagation.tgw](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_transit_gateway_route_table_propagation) | resource |
| [aws_ec2_transit_gateway_vpc_attachment.tgw](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_transit_gateway_vpc_attachment) | resource |
| [aws_route.subnets](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route_table.subnets](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table_association.subnets](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_subnet.subnets](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_vpc.vpc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| az\_set | "Map of availability zones. It overrides the variable availability\_zones" Example: ```az_set = { az1 = "us-east-1a" az2 = "us-east-1b" az3 = "us-east-1c" }``` | `map(string)` | `{}` | no |
| ipam\_pool\_id | IPAM pool id to get the VPc CIDR [required if vpc\_cidr is not informed] | `string` | `null` | no |
| private\_routes | Private network CIDR to be routed to the Transit Gateway | `list(string)` | ```[ "10.0.0.0/8", "172.16.0.0/12", "192.168.0.0/16" ]``` | no |
| subnets | The number of subnets per AZ | ```list(object( { name = string newbits = number index = number tgw_attachment = optional(bool) vpc_endpoint = optional(bool) tags = optional(map(string)) } ))``` | n/a | yes |
| tags | Tags for all resources within the VPC | `map(string)` | `{}` | no |
| transit\_gateway\_id | Transit Gateway Id | `string` | n/a | yes |
| transit\_gateway\_propagations | List with Transit Gateway Route Table Ids to propagate the VPC attachment | `map(string)` | n/a | yes |
| transit\_gateway\_route\_table\_id | Transit Gateway Route Table Id to associate the VPC attachment | `string` | n/a | yes |
| vpc\_cidr | VPC CIDR (minimum size /24) [required if ipam\_pool\_id is not informed] | `string` | `null` | no |
| vpc\_tags | Tags for all resources within the VPC | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| route\_tables | Map of route table IDs grouped by name |
| subnets | Map of subnet IDs grouped by name |
| tgw\_attachment\_id | n/a |
| vpc\_id | n/a |
<!-- END_TF_DOCS -->