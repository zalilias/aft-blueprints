# Copyright Amazon.com, Inc. or its affiliates. All rights reserved.
# SPDX-License-Identifier: Apache-2.0

data "aws_region" "primary" {
  provider = aws.primary
}

data "aws_caller_identity" "current" {}

data "aws_organizations_organization" "org" {}
