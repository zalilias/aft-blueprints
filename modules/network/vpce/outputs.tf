# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
# SPDX-License-Identifier: Apache-2.0

output "security_group_id" {
  description = "The ID of the security group"
  value       = try(aws_security_group.endpoints[0].id, "")
}
