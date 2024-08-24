# Copyright Amazon.com, Inc. or its affiliates. All rights reserved.
# SPDX-License-Identifier: Apache-2.0

resource "aws_ec2_transit_gateway_peering_attachment" "requester" {
  provider = aws.peer-requester

  peer_account_id         = var.tgw_accepter_account_id
  peer_region             = var.tgw_accepter_region
  peer_transit_gateway_id = var.tgw_accepter_id
  transit_gateway_id      = var.tgw_requester_id
  tags = merge(
    { Name = "${var.tgw_requester_id}-${var.tgw_requester_region}-to-${var.tgw_accepter_id}-${var.tgw_accepter_region}" },
    var.tags
  )
}

resource "aws_ec2_transit_gateway_peering_attachment_accepter" "accepter" {
  provider = aws.peer-accepter

  transit_gateway_attachment_id = aws_ec2_transit_gateway_peering_attachment.requester.id
  tags = merge(
    { Name = "${var.tgw_requester_id}-${var.tgw_requester_region}-to-${var.tgw_accepter_id}-${var.tgw_accepter_region}" },
    var.tags
  )
}

resource "aws_ec2_transit_gateway_route_table_association" "requester" {
  provider = aws.peer-requester

  transit_gateway_attachment_id  = aws_ec2_transit_gateway_peering_attachment_accepter.accepter.id
  transit_gateway_route_table_id = var.tgw_requester_route_table_id
}

resource "aws_ec2_transit_gateway_route_table_association" "accepter" {
  provider = aws.peer-accepter

  transit_gateway_attachment_id  = aws_ec2_transit_gateway_peering_attachment_accepter.accepter.id
  transit_gateway_route_table_id = var.tgw_accepter_route_table_id
}



