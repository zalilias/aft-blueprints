# Copyright Amazon.com, Inc. or its affiliates. All rights reserved.
# SPDX-License-Identifier: Apache-2.0

variable "tags" {
  type    = map(string)
  description = "Tags to add to resources."
  default = {}
}

variable "opt_in_services" {
  type    = map(string)
  description = "Enabled Opt in services."
  default = {}
}

variable "advanced_features" {
  type    = map(string)
  description = "Enabled Advanced features."
  default = {}
}
