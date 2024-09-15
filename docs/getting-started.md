# Getting started

This getting started guide will walk you through the process of deploying the pattern you selected.

## Prerequisites

AFT Blueprints assumes you already have an AWS account with AWS Control Tower and AWS IAM Identity Center set up, plus an AWS account (within the same AWS organization) dedicated to AFT. If you don't have it, see the guidelines below:

- You can follow the [Getting started with AWS Control Tower](https://docs.aws.amazon.com/controltower/latest/userguide/getting-started-with-control-tower.html){:target="_blank"}  in the AWS Control Tower documentation, to learn how to set up and configure it in your AWS environment.
- To launch a new AWS account to serve as your AFT management account, you can use the AWS Control Tower Account Factory. Check the [Provision accounts with AWS Service Catalog Account Factory](https://docs.aws.amazon.com/controltower/latest/userguide/provision-as-end-user.html){:target="_blank"}  in the AWS Control Tower documentation for more information.

Ensure that you have installed the following tools locally:

- [awscli](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html){:target="_blank"}
- [terraform](https://learn.hashicorp.com/tutorials/terraform/install-cli){:target="_blank"}

## AFT bootstrap

Once you have your the prerequisites done, you can deploy the AFT on your AFT management account. If you already have AFT deployed, you can skip this step.

To deploy the AFT, we have a few bootstrap options:

- If your organization is allowed to use AWS CodeCommit and you intend to use it, you can use the [**aft-bootstrap-pipeline**](https://github.com/aws-samples/aft-bootstrap-pipeline){:target="_blank"} . See the how to do it on the [Implement Account Factory for Terraform (AFT) by using a bootstrap pipeline](https://docs.aws.amazon.com/prescriptive-guidance/latest/patterns/implement-account-factory-for-terraform-aft-by-using-a-bootstrap-pipeline.html){:target="_blank"}  guide.

- Another option is to follow the steps outlined in the AWS Control Tower Guide workshop. See the section [Account Factory for Terraform (AFT)](https://catalog.workshops.aws/control-tower/en-US/customization/aft/deploy).

- Lastly, you can also follow the [Deploy AWS Control Tower Account Factory for Terraform (AFT)](https://docs.aws.amazon.com/controltower/latest/userguide/aft-getting-started.html){:target="_blank"}  in the AWS Control Tower documentation.

## Defining your account structure

Before we go into the patterns available in the repository, you need to define the structure of AWS accounts and Organization Units (OUs) in AWS Organizations. We developed the patterns based on the AWS best practices for multi-account strategy. Please, check out the whitepaper [Organizing Your AWS Environment Using Multiple Accounts](https://docs.aws.amazon.com/whitepapers/latest/organizing-your-aws-environment/organizing-your-aws-environment.html){:target="_blank"} , especially the section [Recommended OUs and accounts](https://docs.aws.amazon.com/whitepapers/latest/organizing-your-aws-environment/recommended-ous-and-accounts.html){:target="_blank"} .

We have also prepared an architecture diagram with our recommended structure of OUs and accounts for patterns available here. It is available at [AWS Organizations OU and account structure](./architectures/account-structure.md){:target="_blank"} .

## Selecting your pattern

You can check all the available patterns at [Patterns](./patterns.md){:target="_blank"}  section. They all have different components and architectures, from single-region landing zone to multi-region with centralized network inspection. You can choose the right one for your needs, but please, keep in mind that depending on the pattern, the final cost of the environment may be higher or lower.

## Preparing AFT repositories

For each pattern, regardless of the one you have chosen, we have provided the content for all repositories (4) used in the AFT solution:

- **aft-account-customizations**
- **aft-global-customizations**
- **aft-account-provisioning-customizations**
- **aft-account-request**

Your first step is to copy the content for each into your own repositories configured in your AFT deployment. Do not commit and push yet, you need to make some adjustments.

### **aft-account-customizations**

1. In the **aft-account-customizations**, you must copy the [`modules`](https://github.com/awslabs/aft-blueprints/tree/main/modules) folder to the `common` directory. (e.g /common/modules)
2. You also need to provide your own values for each customization folder inside the **aft-account-customizations**. Please, follow the instructions in the `README.md` file inside each terraform folder for each customization (e.g. /NETWORK/terraform/README.md).
3. Once you have completed the last step, you can commit and push the changes to your **aft-account-customizations**.

### **aft-global-customizations**

1. For the **aft-global-customizations**, please follow the instructions in the `README.md` file inside the terraform folder (e.g. /terraform/README.md).
2. Once you have completed the last step, you can commit and push the changes to your **aft-global-customizations**.

### **aft-account-provisioning-customizations**

1. For now **aft-account-provisioning-customizations**, please follow the instructions in the `README.md` file inside the terraform folder (e.g. /terraform/README.md).
2. Once you have completed the last step, you can commit and push the changes to your **aft-account-provisioning-customizations**.
3. Make sure the **ct-aft-account-provisioning-customizations** pipeline in the AFT management account has run and completed successfully.

### **aft-account-request**

1. The **aft-account-request** is covered in the next section.

## Launching core accounts

Now, you should be able to launch your core accounts, one for each core architecture: Network, Backup and Identity. To do so, please follow steps below:

1. Edit the respective files for each account (`network.tf`, `backup.tf` and `identity.tf`) and replace the values in the `control_tower_parameters`, `account_tags` and `change_management_parameters` with your own values.
2. Once you have completed the last step, you can commit and push the changes to your **aft-account-request**.
3. Go to the AWS Control Tower management account and wait for the three account to be enrolled in AWS Control Tower. (It may take 30min or more)
4. Go back to the AFT management account and wait for each account-related pipeline to complete before proceeding to the next step. (If any of them fail, try running the pipeline again.)

## Launching workload accounts

Before you start launching your workload accounts, please check your three core accounts. Check if all of them have the services deployed and configured according to the chosen pattern.

1. We made available three workload account files: `development.tf.hold`, `stage.tf.hold`and `production.tf.hold`). You can launch any one of them, or all three at the same time, but first remove the `.hold` extension for the ones you are intended to use.
2. Edit the files that you removed the `.hold` extension, and replace the values in the `control_tower_parameters`, `account_tags` and `change_management_parameters` with your own values.
3. Go to the AWS Control Tower management account and wait for the three account to be enrolled in AWS Control Tower. (It may take 30min or more)
4. Go back to the AFT management account and wait for each account-related pipeline to complete before proceeding to the next step.
5. Please, check your new accounts to make sure they are set up correctly.
