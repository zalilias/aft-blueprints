# Copyright Amazon.com, Inc. or its affiliates. All rights reserved.
# SPDX-License-Identifier: Apache-2.0

variable "dx_gateway_id" {
  type        = string
  description = "DX Gateway ID."
  default     = ""
}

variable "associated_gateway_id" {
  type        = string
  description = "Gateway ID to be associated to DX Gateway."
  default     = ""
}

variable "allowed_prefixes" {
  type        = list(string)
  description = "List of allowed prefixes."
  default     = []
}

variable "tgw_rt_association" {
  description = "Transit Gateway route table ID to be associated with the DX GW attachment."
  type        = string
}

variable "tgw_rt_propagations" {
  description = "Transit Gateway route table IDs to propagate routes based DX GW BGP configuration."
  type        = list(string)
}
