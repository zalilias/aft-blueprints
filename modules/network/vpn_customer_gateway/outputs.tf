# Copyright Amazon.com, Inc. or its affiliates. All rights reserved.
# SPDX-License-Identifier: Apache-2.0

output "customer_gateway_id" {
  description = "Customer Gateway ID"
  value       = aws_customer_gateway.customer_gateway.id
}
