# Copyright Amazon.com, Inc. or its affiliates. All rights reserved.
# SPDX-License-Identifier: Apache-2.0

variable "phz_id" {
  type        = string
  description = "The Private Hosted Zone ID"
  default     = null
}

variable "region" {
  type        = string
  description = "The VPC region"
  default     = null
}
