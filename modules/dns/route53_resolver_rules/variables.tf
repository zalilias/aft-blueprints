# Copyright Amazon.com, Inc. or its affiliates. All rights reserved.
# SPDX-License-Identifier: Apache-2.0

variable "rules" {
  description = <<-EOF
  The object with attributes for each resolver rule.
  Example:
    ```
    rules = {
      rule_name          = "rr-on-aws"
      rule_type          = "FORWARD"
      associate_to_vpc   = false
      target_ips         = ["10.10.0.7","10.10.128.132"]
      domain_name        = "my-dns-zone.internal"
    }
    ```
EOF
  type = map(object(
    {
      rule_name          = optional(string)       # If it is omitted, the domain name will be used.
      rule_type          = optional(string)       # SYSTEM or FORWARD. (default)
      resource_share_arn = optional(string)       # If it is omitted, it will be shared with the entire organization.
      associate_to_vpc   = optional(bool)         # Whether to associate or not the rule to VPC [var.vpc_id]. (default is false)
      target_ips         = optional(list(string)) # If it is omitted, the resolver inbound IPs will be used, only for rule_type = FORWARD.
      domain_name        = string
    }
  ))
}

variable "resolver_endpoint_id" {
  description = "The resolver OUTBOUND endpoint ID to associate resolver rules. Required if rule_type = FORWARD"
  type        = string
  default     = null
}

variable "resolver_target_ips" {
  description = "The resolver INBOUND endpoint IPs."
  type        = list(string)
  default     = []
}

variable "vpc_id" {
  description = "The VPC to associate resolver rules."
  type        = string
  default     = null
}

variable "tags" {
  description = "Define additional tags to be used by resources."
  type        = map(any)
  default     = {}
}
