# Copyright Amazon.com, Inc. or its affiliates. All rights reserved.
# SPDX-License-Identifier: Apache-2.0

###########################################################
##############        Inbound Resolver       ##############
###########################################################
resource "aws_security_group" "inbound" {
  name_prefix = "${var.route53_resolver_name}-inbound-sgp-"
  description = "Allow DNS Traffic to Route 53 Inbound Resolver Endpoint"
  vpc_id      = var.vpc_id

  tags = merge(
    { "Name" = "${var.route53_resolver_name}-inbound-sgp" },
    var.tags
  )

  lifecycle {
    # Necessary if changing 'name' or 'name_prefix' properties.
    create_before_destroy = true
  }
}

resource "aws_vpc_security_group_ingress_rule" "inbound" {
  for_each = toset(var.rfc1918_cidr)

  security_group_id = aws_security_group.inbound.id
  description       = "Allow DNS communication from private range"
  cidr_ipv4         = each.value
  from_port         = 53
  ip_protocol       = "udp"
  to_port           = 53
}

resource "aws_route53_resolver_endpoint" "inbound" {
  name               = "${var.route53_resolver_name}-inbound"
  direction          = "INBOUND"
  security_group_ids = [aws_security_group.inbound.id]
  dynamic "ip_address" {
    for_each = var.route53_resolver_subnet_ids
    content {
      subnet_id = ip_address.value
    }
  }
  tags = merge(
    { "Name" = "${var.route53_resolver_name}-inbound" },
    var.tags
  )
}


###########################################################
##############       Outbound Resolver       ##############
###########################################################
resource "aws_security_group" "outbound" {
  name_prefix = "${var.route53_resolver_name}-outbound-sgp-"
  description = "Allow DNS Traffic from Route 53 Outbound Resolver Endpoint"
  vpc_id      = var.vpc_id

  tags = merge(
    { "Name" = "${var.route53_resolver_name}-outbound-sgp" },
    var.tags
  )

  lifecycle {
    # Necessary if changing 'name' or 'name_prefix' properties.
    create_before_destroy = true
  }
}

resource "aws_vpc_security_group_egress_rule" "outbound" {
  security_group_id = aws_security_group.outbound.id
  description       = "Allow DNS communication"
  from_port         = 53
  to_port           = 53
  ip_protocol       = "udp"
  cidr_ipv4         = "0.0.0.0/0"
}

resource "aws_route53_resolver_endpoint" "outbound" {
  name               = "${var.route53_resolver_name}-outbound"
  direction          = "OUTBOUND"
  security_group_ids = [aws_security_group.outbound.id]
  dynamic "ip_address" {
    for_each = var.route53_resolver_subnet_ids
    content {
      subnet_id = ip_address.value
    }
  }
  tags = merge(
    { "Name" = "${var.route53_resolver_name}-outbound" },
    var.tags
  )
}
