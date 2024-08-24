## Description

Creates the VPN resource connected to the TGW

<!-- BEGIN_TF_DOCS -->

## Requirements

| Name      | Version |
| --------- | ------- |
| terraform | >=1.5.0 |
| aws       | >=5.0.0 |

## Providers

| Name | Version |
| ---- | ------- |
| aws  | >=5.0.0 |

## Modules

No modules.

## Resources

| Name                                                                                                                                             | Type        |
| ------------------------------------------------------------------------------------------------------------------------------------------------ | ----------- |
| [aws_vpn_connection.vpn_connection](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpn_connection)                  | resource    |
| [aws_organizations_organization.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/organizations_organization) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region)                                      | data source |

## Inputs

| Name                     | Description                                                                     | Type          | Default       | Required |
| ------------------------ | ------------------------------------------------------------------------------- | ------------- | ------------- | :------: |
| customer_gateway_id      | The Customer gateway ID                                                         | `string`      | n/a           |   yes    |
| local_ipv4_network_cidr  | The IPv4 CIDR on the customer gateway (on-premises) side of the VPN connection. | `string`      | `"0.0.0.0/0"` |    no    |
| region                   | Network Hub account main region                                                 | `string`      | n/a           |   yes    |
| remote_ipv4_network_cidr | The IPv4 CIDR on the customer gateway (on-premises) side of the VPN connection. | `string`      | `"0.0.0.0/0"` |    no    |
| static_routes_only       | Whether the VPN connection uses static routes exclusively.                      | `bool`        | `false`       |    no    |
| tags                     | n/a                                                                             | `map(string)` | `{}`          |    no    |
| transit_gateway_id       | The Transit Gateway ID                                                          | `string`      | n/a           |   yes    |

## Outputs

| Name                          | Description       |
| ----------------------------- | ----------------- |
| transit_gateway_attachment_id | TGW Attachment ID |
| vpn_connection_id             | VPN Connection ID |

<!-- END_TF_DOCS -->
