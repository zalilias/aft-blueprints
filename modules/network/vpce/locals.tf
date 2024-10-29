# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
# SPDX-License-Identifier: Apache-2.0

locals {
  create_security_group = var.security_group_id == null && length(var.interface_endpoints.services) > 0
}
