# Copyright Amazon.com, Inc. or its affiliates. All rights reserved.
# SPDX-License-Identifier: Apache-2.0

output "transit_gateway_id" {
  description = "Transit Gateway Id"
  value       = aws_ec2_transit_gateway_vpc_attachment.this.transit_gateway_id
}

output "transit_gateway_attachment_id" {
  description = "Transit Gateway Attachment Id"
  value       = aws_ec2_transit_gateway_vpc_attachment.this.id
}

