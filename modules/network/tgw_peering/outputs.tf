# Copyright Amazon.com, Inc. or its affiliates. All rights reserved.
# SPDX-License-Identifier: Apache-2.0

output "tgw_attachment_id" {
  description = "Transit Gateway Attachment Id"
  value       = aws_ec2_transit_gateway_peering_attachment_accepter.accepter.id
}
