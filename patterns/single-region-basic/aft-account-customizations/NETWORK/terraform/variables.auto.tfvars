# Copyright Amazon.com, Inc. or its affiliates. All rights reserved.
# SPDX-License-Identifier: Apache-2.0

aws_ip_address_plan = {
  global_cidr_blocks = ["10.10.0.0/16", "10.20.0.0/16"]
  primary_region = {
    cidr_blocks = ["10.10.0.0/16"]
    shared = {
      cidr_blocks = ["10.10.0.0/18"]
    }
    prod = {
      cidr_blocks = ["10.10.64.0/18"]
    }
    stage = {
      cidr_blocks = ["10.10.128.0/18"]
    }
    dev = {
      cidr_blocks = ["10.10.192.0/18"]
    }
  }
}

aws_availability_zones = {
  primary_region = {
    az1 = "us-east-1a"
    az2 = "us-east-1b"
  }
}
