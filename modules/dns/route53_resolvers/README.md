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
| [aws_ram_principal_association.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ram_principal_association) | resource |
| [aws_ram_resource_association.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ram_resource_association) | resource |
| [aws_ram_resource_share.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ram_resource_share) | resource |
| [aws_route53_resolver_endpoint.inbound](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_resolver_endpoint) | resource |
| [aws_route53_resolver_endpoint.outbound](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_resolver_endpoint) | resource |
| [aws_route53_resolver_rule.forward](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_resolver_rule) | resource |
| [aws_route53_resolver_rule_association.forward](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_resolver_rule_association) | resource |
| [aws_security_group.inbound](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.outbound](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_organizations_organization.org](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/organizations_organization) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| rfc1918\_cidr | List of private address cidrs. | `list(string)` | ```[ "192.168.0.0/16", "172.16.0.0/12", "10.0.0.0/8" ]``` | no |
| route53\_resolver\_name | The name for your resolver endpoint. The module will append '-inbound' or '-outbound' to the name. | `string` | `"resolver-endpoint"` | no |
| route53\_resolver\_subnet\_ids | List of subnet ids to be used by resolver to create a interface endpoint. | `list(string)` | `null` | no |
| rules | The domain\_name and external\_dns\_ips (if applicable) for the resolver rule to forward requests. | ```list(object( { domain_name = string external_dns_ips = optional(list(string), []) } ))``` | n/a | yes |
| tags | Define additional tags to be used by resources. | `map(any)` | `{}` | no |
| vpc\_id | The VPC to associate with resolver endpoint. | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| route53\_resolver\_endpoint\_inbound | n/a |
| route53\_resolver\_endpoint\_outbound | n/a |
| route53\_resolver\_rule\_fwd\_to\_domain | n/a |
<!-- END_TF_DOCS -->