# Copyright Amazon.com, Inc. or its affiliates. All rights reserved.
# SPDX-License-Identifier: Apache-2.0

output "vpn_connection_id" {
  description = "VPN Connection ID"
  value       = aws_vpn_connection.vpn_connection.id
}

output "transit_gateway_attachment_id" {
  description = "TGW Attachment ID"
  value       = aws_vpn_connection.vpn_connection.transit_gateway_attachment_id
}
