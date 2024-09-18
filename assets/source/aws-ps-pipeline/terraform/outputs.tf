# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
# SPDX-License-Identifier: Apache-2.0

output "permission_sets" {
  value = module.aws_permission_sets.permission_sets
}

output "assignments" {
  value = module.aws_permission_sets.assignments
}
