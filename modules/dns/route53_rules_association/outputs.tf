# Copyright Amazon.com, Inc. or its affiliates. All rights reserved.
# SPDX-License-Identifier: Apache-2.0

output "aws_route53_resolver_rules" {
  value = data.aws_route53_resolver_rules.shared_resolvers
}
