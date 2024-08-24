# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
# SPDX-License-Identifier: Apache-2.0

resource "aws_security_group" "endpoints" {
  count = length(var.interface_endpoints.services) > 0 ? 1 : 0

  name_prefix = "${var.vpc_name}-endpoints-sgp-"
  description = "Allow endpoints communication within the VPC"
  vpc_id      = var.vpc_id

  ingress {
    description = "Allow ALL trafic from VPC"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = var.allowed_cidr
  }

  egress {
    description = "Allow ALL egress trafic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    { "Name" = "${var.vpc_name}-endpoints-sgp" },
    var.tags
  )

  lifecycle {
    # Necessary if changing 'name' or 'name_prefix' properties.
    create_before_destroy = true
  }
}

resource "aws_vpc_endpoint" "interface" {
  for_each = toset(var.interface_endpoints.services)

  vpc_id              = var.vpc_id
  service_name        = "com.amazonaws.${data.aws_region.current.name}.${each.value}"
  vpc_endpoint_type   = "Interface"
  security_group_ids  = [aws_security_group.endpoints[0].id]
  subnet_ids          = var.interface_endpoints.subnet_ids
  private_dns_enabled = each.value == "s3" ? false : true
  policy = each.value == "ssm" ? jsonencode({
    Version : "2012-10-17",
    Statement : [
      {
        Sid : "AllowAll",
        Effect : "Allow",
        Principal : {
          AWS : "*"
        },
        Action : [
          "ssm:List*",
          "ssm:Get*",
          "ssm:UpdateInstanceInformation*"
        ],
        Resource : "*"
      }
    ]
  }) : null
  tags = merge(
    { "Name" = "${var.vpc_name}-${each.value}-endpoint" },
    var.tags
  )
  timeouts {
    create = "10m"
    update = "10m"
    delete = "10m"
  }
}

resource "aws_vpc_endpoint" "gateway" {
  for_each = toset(var.gateway_endpoints.services)

  vpc_id            = var.vpc_id
  service_name      = "com.amazonaws.${data.aws_region.current.name}.${each.value}"
  vpc_endpoint_type = "Gateway"
  route_table_ids   = var.gateway_endpoints.route_table_ids
  tags = merge(
    { "Name" = "${var.vpc_name}-${each.value}-endpoint" },
    var.tags
  )
  timeouts {
    create = "10m"
    update = "10m"
    delete = "10m"
  }
}
