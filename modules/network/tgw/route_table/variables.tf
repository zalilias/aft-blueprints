# Copyright Amazon.com, Inc. or its affiliates. All rights reserved.
# SPDX-License-Identifier: Apache-2.0

variable "route_table_name" {
  description = "TGW Route Table Name"
  type        = string
}

variable "transit_gateway_id" {
  description = "Transit Gateway Id"
  type        = string
}

variable "default_route_attachment_id" {
  description = "Id do Attachment da VPC de Inspection"
  type        = string
  default     = ""
}

variable "tags" {
  type    = map(string)
  default = {}
}
