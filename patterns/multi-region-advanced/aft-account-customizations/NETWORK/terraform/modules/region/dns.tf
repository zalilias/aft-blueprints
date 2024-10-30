# Copyright Amazon.com, Inc. or its affiliates. All rights reserved.
# SPDX-License-Identifier: Apache-2.0

module "route53_resolvers" {
  source = "../../../../common/modules/dns/route53_resolvers"

  vpc_id                      = module.vpc_endpoints.vpc_id
  route53_resolver_subnet_ids = module.vpc_endpoints.subnets["private"]
  tags                        = var.tags
}

module "route53_resolver_rules" {
  source = "../../../../common/modules/dns/route53_resolver_rules"

  rules                = local.dns_resolver_rules
  resolver_endpoint_id = module.route53_resolvers.outbound_endpoint_id
  resolver_target_ips  = module.route53_resolvers.inbound_endpoint_ips
  tags                 = var.tags
}

