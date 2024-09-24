# Getting started

This getting started guide will walk you through the process of deploying the pattern you selected.

## Prerequisites

AFT Blueprints assumes you already have an AWS account with AWS Control Tower and AWS IAM Identity Center set up, plus an AWS account (within the same AWS organization) dedicated to deploy and manage AFT. If you don't have it, see the guidelines below:

- To learn how to set up and configure AWS Control Tower in your environment, please follow the [Getting started with AWS Control Tower](https://docs.aws.amazon.com/controltower/latest/userguide/getting-started-with-control-tower.html){:target="_blank"}.
- To launch a new AWS account to serve as your AFT management account, please follow the [Provision accounts with AWS Service Catalog Account Factory](https://docs.aws.amazon.com/controltower/latest/userguide/provision-as-end-user.html){:target="_blank"} in the AWS Control Tower documentation.

Ensure that you have installed the following tools locally:

- [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html){:target="_blank"}
- [Terraform](https://learn.hashicorp.com/tutorials/terraform/install-cli){:target="_blank"}

## AFT bootstrap

Once all the prerequisites are done, deploy AFT on its dedicated management account. If you already have AFT deployed, you can skip this step.

To deploy the AFT, we have a few bootstrap options:

- If your organization is allowed to use AWS CodeCommit and you intend to use it, make use of the [**aft-bootstrap-pipeline**](https://github.com/aws-samples/aft-bootstrap-pipeline){:target="_blank"} . See the how to do it on the [Implement Account Factory for Terraform (AFT) by using a bootstrap pipeline](https://docs.aws.amazon.com/prescriptive-guidance/latest/patterns/implement-account-factory-for-terraform-aft-by-using-a-bootstrap-pipeline.html){:target="_blank"}  guide.

- Another option is to follow the steps outlined in the AWS Control Tower Guide workshop. See the section [Account Factory for Terraform (AFT)](https://catalog.workshops.aws/control-tower/en-US/customization/aft/deploy).

- Lastly, you can also follow the [Deploy AWS Control Tower Account Factory for Terraform (AFT)](https://docs.aws.amazon.com/controltower/latest/userguide/aft-getting-started.html){:target="_blank"}  in the AWS Control Tower documentation.

## Defining your account structure

Before going into the patterns available, you must define the structure of AWS accounts and Organization Units (OUs) within AWS Organizations. We developed the patterns based on the AWS best practices for multi-account strategy. Please, check out the whitepaper [Organizing Your AWS Environment Using Multiple Accounts](https://docs.aws.amazon.com/whitepapers/latest/organizing-your-aws-environment/organizing-your-aws-environment.html){:target="_blank"} , especially the section [Recommended OUs and accounts](https://docs.aws.amazon.com/whitepapers/latest/organizing-your-aws-environment/recommended-ous-and-accounts.html){:target="_blank"} .

We have also prepared an architecture diagram with our recommended structure of OUs and accounts for patterns available here. It is available at [AWS Organizations OU and account structure](./architectures/account-structure.md){:target="_blank"} .

## Selecting your pattern

Check all the available patterns at [Patterns](./patterns.md){:target="_blank"} section. They all have different components and architectures, from single-region landing zone to multi-region with centralized network inspection. Choose the right one for your needs, but please, keep in mind that depending on the pattern, the final cost of the environment may be higher or lower.

## Understanding the Landing Zone parameters

To automate the deployment of a Landing Zone, the patterns leverage AWS Systems Manager (SSM) parameters to guide the creation of resources across a multi-account environment. The following content outlines the specific parameters that are created in each account for this purpose.

**AFT management account:**

- `/org/core/accounts/network`:  Network Account Id.
- `/org/core/accounts/backup`: Backup Account Id.
- `/org/core/accounts/identity`: Identity Account Id.

**Network account:**

- `/org/core/network/availability-zones/{{ az-id }}`: Availability Zone Id to keep the consistency for VPCs across different accounts.
- `/org/core/network/tgw-id`: The Id of the shared Transit Gateway.
- `/org/core/network/tgw-route-table/{{ network-segment }}`: Transit Gateway route table Id to associate the VPC attachment for network segment (environment).
- `/org/core/network/tgw-propagation-rules`:  VPC attachment propagation rules for all network segments.

## Preparing AFT repositories

For each pattern, regardless of the one you have chosen, we have provided the content for all repositories (4) used in the AFT solution:

- **aft-global-customizations**
- **aft-account-customizations**
- **aft-account-provisioning-customizations**
- **aft-account-request**

First, access the [aft-blueprints](https://github.com/awslabs/aft-blueprints) repository. Then, navigate to the `patterns` directory and select the pattern you want to use. Copy the content for each repository into your own repositories configured in your AFT deployment. Do not commit and push yet, you need to make some adjustments.

### **aft-global-customizations**

1. For the **aft-global-customizations**, please follow the instructions in the `README.md` file inside the `terraform` directory (e.g. /terraform/README.md).
2. Once you have completed the last step, commit and push the changes to your **aft-global-customizations**.

### **aft-account-customizations**

1. In the **aft-account-customizations**, you must copy the [`modules`](https://github.com/awslabs/aft-blueprints/tree/main/modules) directory to the `common` directory. (e.g /common/modules)
2. You also need to provide your own values for each customization directory inside the **aft-account-customizations**. Please, follow the instructions in the `README.md` file inside each `terraform` directory for each customization (e.g. /NETWORK/terraform/README.md).
3. Once you have completed the last step, commit and push the changes to your **aft-account-customizations**.

### **aft-account-provisioning-customizations**

1. For now **aft-account-provisioning-customizations**, please follow the instructions in the `README.md` file inside the `terraform` directory (e.g. /terraform/README.md).
2. Once you have completed the last step, commit and push the changes to your **aft-account-provisioning-customizations**.
3. Make sure the **ct-aft-account-provisioning-customizations** pipeline in the AFT management account has run and completed successfully.

### **aft-account-request**

1. The **aft-account-request** is covered in the next section.

## Launching core accounts

Now, you should be able to launch your core accounts, one for each core architecture: Network, Backup and Identity. To do so, please follow steps below:

1. Edit the respective files for each account (`network.tf`, `backup.tf` and `identity.tf`) and replace the values in the `control_tower_parameters`, `account_tags` and `change_management_parameters` with your own values.
2. Once you have completed the last step, commit and push the changes to your **aft-account-request**.
3. Go to the AWS Control Tower management account and wait for the three account to be enrolled in AWS Control Tower. (It may take 30min or more)
4. Go back to the AFT management account and wait for each account-related pipeline to complete before proceeding to the next step. (If any of them fail, try running the pipeline again.)

## Launching workload accounts

Before you start launching your workload accounts, please check your three core accounts. Check if all of them have the services deployed and configured according to the chosen pattern.

1. We made available three workload account files: `development.tf.hold`, `stage.tf.hold`and `production.tf.hold`). You can launch any one of them, or all three at the same time, but first remove the `.hold` extension for the ones you are intended to use.
2. Edit the files that you removed the `.hold` extension, and replace the values in the `control_tower_parameters`, `account_tags` and `change_management_parameters` with your own values.
3. Go to the AWS Control Tower management account and wait for the three account to be enrolled in AWS Control Tower. (It may take 30min or more)
4. Go back to the AFT management account and wait for each account-related pipeline to complete before proceeding to the next step.
5. Please, check your new accounts to make sure they are set up correctly.
