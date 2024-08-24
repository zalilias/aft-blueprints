# Copyright Amazon.com, Inc. or its affiliates. All rights reserved.
# SPDX-License-Identifier: Apache-2.0

variable "common_parameters" {
  type = object({
    app_name      = string
    account_email = string
    account_tags  = map(any)
    change_management_parameters = object({
      change_requested_by = string
      change_reason       = string
    })
  })
}
