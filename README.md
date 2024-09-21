# Account Factory for Terraform (AFT) Blueprints

Welcome to AWS Account Factory for Terraform (AFT) Blueprints!

This project provides a collection of AFT customization patterns for the AWS Control Tower landing zone. These patterns demonstrate how to implement core service architectures in a greenfield environment, that can be used as examples by AWS customers, partners, and internal AWS teams.

## Introducing AFT Blueprints

The AFT Blueprints project provides a set of pre-defined architectural patterns which can be easily deployed using AWS Control Tower and the Account Factory for Terraform (AFT). These patterns serve as a blueprint for a comprehensive landing zone, enabling users to kickstart their cloud journey with a robust and secure foundation. The project currently provides example architectures for the following services within the Control Tower environment: Network and DNS, Centralized Backup, Identity Management, and Security.

The approach used in this project involves dynamic Terraform providers and a parametrized Landing Zone, aiming to minimize the complexity of the deployment process. The idea is to leverage integrations between the various architectural components, enabling cross-account and cross-region automation workflows, without requiring complex configuration inputs from the user. The objective is to streamline the deployment process, so that users only need to provision the target accounts with minimal environment-specific variable inputs.

The core goal of the AFT Blueprints project is to empower AWS customers to accelerate their cloud transformation. It does this by providing a proven and highly automated approach. By offering these predefined architectural patterns, the project aims to help organizations reduce the time and effort required to establish a cloud-ready environment at the outset of their cloud journey.

## Consumption

AFT Blueprints is designed to assist customers in the early stages of their cloud journey. These blueprints can be utilized in the following ways:

- Copying the pattern content into customer's own AFT repositories to use as a starting point for their AWS Landing Zone. Customers are then free to customize the provided patterns to meet their specific needs.
- Using the patterns as a reference guide, which can helping customers to build their own patterns. By reading the documentation and examining the code, customers can understand how a particular pattern or architecture was built, and then apply similar logic to develop their own tailored solutions.

## Repository structure

This repository contains the Terraform code for various AWS architectural patterns, which re-uses a set of Terraform modules across all of them. We organized the repository structure to have two main directories: **patterns** and **modules**.

### Pattern directory

The `pattern` directory houses the different AWS architectural patterns. Each pattern is contained within its own subdirectory, named according to the pattern it represents (e.g., "single-region-basic", "multi-region-advanced"). The code within these pattern directories define the complete AWS infrastructure required to deploy the corresponding architecture. This allows users to easily identify, understand, and deploy the different architectural patterns supported by this repository.

### Modules directory

The `modules` directory contains reusable Terraform modules leveraged across multiple AWS architectural patterns. These modules encapsulate specific AWS resources or configurations, such as IAM policies, logging configurations, or networking setups. By separating the modules from the patterns, the repository maintains a clear separation of concerns, making it easier to manage, update, and apply consistent configurations across different patterns. This structure enables a modular and organized approach to managing the AWS architectural patterns and their supporting resources, promoting code reuse and maintainability.

## Things to keep in mind

- The code in this repository is provided as an example only, and is not intended for production use. However, users are free to modify the patterns locally after cloning the repository, in order to suit their own requirements.
- The patterns provided in this project are not meant to be directly consumed and used as-is, like a module. They are intended as sample code to be referenced by the corresponding AFT repository.
- The AFT Blueprints project does not aim to teach users the recommended practices for working with Terraform. It also does not provide guidance on how users should structure their own Terraform projects.
- The AFT Blueprints is maintained by a mixed team of AWS internal staff, including Professional Services Consultants and Solution Architects. This project is not part of an official AWS service and support is provided on a best-effort basis.

## Security

See [CONTRIBUTING](https://github.com/awslabs/aft-blueprints/blob/main/CONTRIBUTING.md#security-issue-notifications){:target="\_blank"} for more information.

## License

This project is licensed under the Apache-2.0 License.
