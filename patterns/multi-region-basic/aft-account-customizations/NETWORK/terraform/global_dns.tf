# Copyright Amazon.com, Inc. or its affiliates. All rights reserved.
# SPDX-License-Identifier: Apache-2.0

########################################
#######     Global Resources     #######
########################################
module "main_phz" {
  source = "../../common/modules/dns/route53_phz"
  providers = {
    aws = aws.primary
  }

  name               = "on.aws"
  create_test_record = true
  vpc_id             = module.primary_region.endpoints_vpc_id
  add_vpc = {
    secondary = {
      vpc_id = module.secondary_region.endpoints_vpc_id
      region = data.aws_region.secondary.name
    }
  }
  tags = local.tags
}
