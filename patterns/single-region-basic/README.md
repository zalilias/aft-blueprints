# Single region basic pattern

The **single region basic** AFT pattern provides a foundational cloud architecture, covering key services and configurations to establish a secure, multi-environment landing zone in a single AWS Region.

## Network

The network design features a centralized egress VPC using a NAT Gateway, along with segregated environments for shared services, production, staging, and development. Ingress traffic is distributed and managed within each workload VPC on its public subnet.

The traffic between the workload environments (prod, stage, dev) is isolated and not routed, while traffic to/from the shared services environment is routed to all other environments. All VPCs make use of a centralized VPC flow logs mechanism, sending traffic logs to the Control Tower's Log Archive account.

Additionally, to enable effective IP management integrated with AWS services, the Network account is used as the delegated administrator of the AWS VPC IP Address Manager for the entire organization. Different IP pools are created for each environment mentioned above, making it easier to control and manage IP addresses and routing domains.

See more details in the [Network Basic](../../docs/architectures/network-basic.md){:target="_blank"} architecture page.

## Backup

The pattern also includes a centralized backup architecture with local vaults and a central vault in a dedicated AWS Backup account, providing consolidated backup management and recovery across the environments.

See more details in the [Centralized Backup](../../docs/architectures/aws-backup.md){:target="_blank"} architecture page.

## Identity Management

Additionally, the pattern sets up a delegated administrator account for the AWS IAM Identity Center and IAM Access Analyzer services. This includes a Terraform-based pipeline to dynamically deploy and manage Permission Sets, and an analyzer for external access analysis at organization level.

See more details in the [Identity Management](../../docs/architectures/identity-management.md){:target="_blank"} architecture page.

## Security

All the patterns include the same configuration for basic AWS Security services, such as AWS Security Hub and Amazon GuardDuty.

See more details in the [Security Services](../../docs/architectures/security.md){:target="_blank"} architecture page.

## Global Customizations

This pattern also includes global customizations that are applied across all accounts. These encompass the definition of the IAM password policy, as well as account-level configurations such as S3 Block Public Access, AMI Block Public Access, EBS Encryption Enforcement, and IMDSv2 Enforcement.

## Account Provisioning Customizations

No account provisioning customizations other than the AFT default are available for this pattern.
