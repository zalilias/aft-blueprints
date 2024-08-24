# Copyright Amazon.com, Inc. or its affiliates. All rights reserved.
# SPDX-License-Identifier: Apache-2.0

module "bastion" {
  source = "../../../common/modules/compute/ec2_bastion"
  count  = var.vpc == null ? 0 : 1

  identifier = module.vpc[0].identifier
  vpc_id     = module.vpc[0].vpc_id
  subnet_id  = module.vpc[0].private_subnets[0]
  tags = merge(
    { "ec2-backup" = true },
    var.tags
  )
}
