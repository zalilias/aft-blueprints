# Copyright Amazon.com, Inc. or its affiliates. All rights reserved.
# SPDX-License-Identifier: Apache-2.0

data "aws_organizations_organization" "org" {}

data "aws_route53_resolver_endpoint" "inbound" {
  resolver_endpoint_id = aws_route53_resolver_endpoint.inbound.id
}

data "aws_route53_resolver_endpoint" "outbound" {
  resolver_endpoint_id = aws_route53_resolver_endpoint.outbound.id
}
