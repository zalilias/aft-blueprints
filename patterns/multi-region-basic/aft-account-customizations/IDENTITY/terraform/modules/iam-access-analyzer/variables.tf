# Copyright Amazon.com, Inc. or its affiliates. All rights reserved.
# SPDX-License-Identifier: Apache-2.0

variable "name" {
  type        = string
  description = "Name of the IAM Analyzier"
  default     = "iam-analyzer"
}

variable "type" {
  type        = string
  description = "Type of the IAM Analyzer"
  default     = "ACCOUNT"
  validation {
    condition     = contains(["ACCOUNT", "ORGANIZATION"], var.type)
    error_message = "Valid values: ACCOUNT | ORGANIZATION"
  }
}

variable "tags" {
  type    = map(string)
  default = {}
}
