# Copyright Amazon.com, Inc. or its affiliates. All rights reserved.
# SPDX-License-Identifier: Apache-2.0

variable "availability_zones" {
  type        = map(string)
  description = <<-EOF
  "Map of availability zones allowed to be used in this region."
  Example:
    ```
    availability_zones = {
      az1 = "us-east-1a"
      az2 = "us-east-1b"
      az3 = "us-east-1c"
    }
    ```
EOF
  validation {
    condition = alltrue(
      [for az in keys(var.availability_zones) : true if contains(["az1", "az2", "az3", "az4"], az)]
    )
    error_message = "You must specify a list with valid availability zones allowed in this region, such as az1, az2, az3 and az4."
  }
}

variable "tags" {
  type    = map(string)
  default = {}
}
