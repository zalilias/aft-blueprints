# Copyright Amazon.com, Inc. or its affiliates. All rights reserved.
# SPDX-License-Identifier: Apache-2.0

variable "name" {
  type        = string
  description = "Name of the hosted zone."
  default     = null
}

variable "vpc_id" {
  type        = string
  description = "Local VPC ID that will be associated with this hosted zone."
  default     = null
}

variable "add_vpc" {
  type = map(object({
    vpc_id = string
    region = string
  }))
  description = "List of local additional VPC (vpc_id and region) that will be associated with this hosted zone."
  default     = {}
}

variable "create_test_record" {
  type        = bool
  description = "Whether create a test record in the private hosted zone."
  default     = false
}

variable "force_destroy" {
  type        = bool
  description = "Whether to destroy all records inside if the hosted zone is deleted."
  default     = false
}

variable "tags" {
  type        = map(any)
  description = "Define additional tags to be used by resources."
  default     = {}
}
