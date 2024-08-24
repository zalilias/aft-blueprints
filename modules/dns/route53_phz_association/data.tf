# Copyright Amazon.com, Inc. or its affiliates. All rights reserved.
# SPDX-License-Identifier: Apache-2.0

data "aws_region" "dns" {
  provider = aws.dns
}

data "aws_vpcs" "this" {
  provider = aws.dns

  filter {
    name   = "tag-key"
    values = ["dns-service"]
  }
}
