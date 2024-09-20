# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
# SPDX-License-Identifier: Apache-2.0

module "aws_permission_sets" {
  source = "aws-ia/permission-sets/aws"

  templates_path = "./templates"
  tags = {
    "managed-by" = "aws-ps-pipeline"
  }
}
