# Multi region basic pattern

The **multi region basic** AFT pattern provides a foundational cloud architecture, covering key services and configurations to establish a secure, multi-environment landing zone in multiple AWS Region.

## Network

At the core of the network design is a multi-region configuration, with cross-region communication facilitated through Transit Gateway peering. The pattern also features a centralized egress VPC using a NAT Gateway, along with segregated environments for shared services, production, staging, and development. Ingress traffic is distributed and managed within each workload VPC on its public subnet.

Traffic between the workload environments (prod, stage, dev) is isolated and not routed, while traffic to/from the shared services environment (DNS, VPC endpoints, infrastructure services, etc.) is routed to all other environments. All VPCs make use of a centralized VPC flow logs mechanism, sending traffic logs to the Control Tower's Log Archive account. 

Additionally, to enable effective IP management integrated with AWS services, the Network account is used as the delegated administrator of the AWS VPC IP Address Manager for the entire organization. Different IP pools are created for each environment mentioned above, making it easier to control and manage IP addresses and routing domains.

The architecture is mirrored across all regions, ensuring that each region has the same services and resources implemented.

See more details in the [Network Intermediate](../../docs/architectures/network-intermediate.md){:target="_blank"} architecture page.

## Backup

The pattern also includes a centralized backup architecture with local vaults and a central vault in a dedicated AWS Backup account, providing consolidated backup management and recovery across the environments.

See more details in the [Centralized Backup](../../docs/architectures/aws-backup.md){:target="_blank"} architecture page.

## Identity Management

Additionally, the pattern sets up a delegated administrator account for the AWS IAM Identity Center service and includes a Terraform-based pipeline to dynamically deploy and manage Permission Sets.

See more details in the [Identity Management](../../docs/architectures/identity-management.md){:target="_blank"} architecture page.

## Security

All the patterns include the same configuration for basic AWS Security services, such as AWS Security Hub and Amazon GuardDuty.

See more details in the [Security Services](../../docs/architectures/security.md){:target="_blank"} architecture page.
