# Copyright Amazon.com, Inc. or its affiliates. All rights reserved.
# SPDX-License-Identifier: Apache-2.0

variable "routing_config" {
  type = map(object({
    tgw_route_table_id = string
    routes = list(object({
      destination_cidr_blocks = list(string)
      tgw_attachment_id       = optional(string)
      blackhole               = optional(bool)
    }))
  }))
  default     = {}
  description = <<-EOF
  List of objects to populate transit gateway route tables.
  Example:
    ```
    routing_config = {
      infra = {
        tgw_route_table_id = "route_table_id_1"
        routes = [
          {
            destination_cidr_blocks = [
              "10.10.10.0/24"
              "10.20.20.0/24"
            ]
            tgw_attachment_id       = "tgw_attachment_id_1"
          }
          {
            destination_cidr_blocks = ["10.30.30.0/24"]
            tgw_attachment_id       = "tgw_attachment_id_2"
          }
        ]
      }
      spoke = {
        tgw_route_table_id = "route_table_id_2"
        routes = [
          {
            destination_cidr_blocks = ["0.0.0.0/0"]
            tgw_attachment_id       = "tgw_attachment_id_3"
          },
          {
            destination_cidr_blocks = ["10.0.0.0/8","172.16.0.0/12","192.168.0.0/24"]
            blackhole               = true
          },
        ]
      }
    }
    ```
EOF
}
