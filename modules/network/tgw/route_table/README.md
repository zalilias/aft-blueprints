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
| [aws_ec2_transit_gateway_route_table.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_transit_gateway_route_table) | resource |
| [aws_ssm_parameter.tgw_route_table](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| default\_route\_attachment\_id | Id do Attachment da VPC de Inspection | `string` | `""` | no |
| route\_table\_name | TGW Route Table Name | `string` | n/a | yes |
| tags | n/a | `map(string)` | `{}` | no |
| transit\_gateway\_id | Transit Gateway Id | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| route\_table\_id | Route Table Id |
<!-- END_TF_DOCS -->