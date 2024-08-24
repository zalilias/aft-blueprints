# Copyright Amazon.com, Inc. or its affiliates. All rights reserved.
# SPDX-License-Identifier: Apache-2.0

variable "tgw_requester_id" {
  description = "Requester Transit Gateway ID"
  type        = string
}

variable "tgw_requester_route_table_id" {
  description = "Requester Transit Gateway route table ID to associate the peering attachment"
  type        = string
}

variable "tgw_requester_region" {
  description = "Requester Transit Gateway region"
  type        = string
}

variable "tgw_accepter_id" {
  description = "Accepter Transit Gateway ID"
  type        = string
}

variable "tgw_accepter_route_table_id" {
  description = "Accepter Transit Gateway route table ID to associate the peering attachment"
  type        = string
}

variable "tgw_accepter_region" {
  description = "Accepter Transit Gateway region"
  type        = string
}

variable "tgw_accepter_account_id" {
  description = "Accepter Transit Gateway ID"
  type        = string
  default     = null
}

variable "tags" {
  type        = map(string)
  description = "Define additional tags to be used by resources."
  default     = {}
}
