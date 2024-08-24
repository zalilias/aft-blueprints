# Copyright Amazon.com, Inc. or its affiliates. All rights reserved.
# SPDX-License-Identifier: Apache-2.0

resource "aws_backup_region_settings" "settings" {
  resource_type_opt_in_preference     = var.opt_in_services
  resource_type_management_preference = var.advanced_features
}
