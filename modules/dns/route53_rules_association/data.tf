# Copyright Amazon.com, Inc. or its affiliates. All rights reserved.
# SPDX-License-Identifier: Apache-2.0

data "aws_route53_resolver_rules" "shared_resolvers" {
  rule_type    = "FORWARD"
  share_status = "SHARED_WITH_ME"
}
