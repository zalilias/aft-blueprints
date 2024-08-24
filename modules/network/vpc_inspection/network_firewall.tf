# Copyright Amazon.com, Inc. or its affiliates. All rights reserved.
# SPDX-License-Identifier: Apache-2.0

resource "aws_networkfirewall_firewall" "nfw" {
  depends_on = [aws_subnet.private]

  name                     = local.firewall_name
  firewall_policy_arn      = aws_networkfirewall_firewall_policy.nfw.arn
  vpc_id                   = aws_vpc.vpc.id
  delete_protection        = true
  subnet_change_protection = true
  encryption_configuration {
    key_id = aws_kms_key.nfw.arn
    type   = "CUSTOMER_KMS"
  }
  dynamic "subnet_mapping" {
    for_each = aws_subnet.private
    content {
      subnet_id = subnet_mapping.value.id
    }
  }
  tags = merge(
    { "Name" = "${local.firewall_name}" },
    var.tags
  )
  lifecycle {
    ignore_changes = [firewall_policy_arn]
  }
}

resource "aws_networkfirewall_firewall_policy" "nfw" {
  name = "${local.vpc_name}-nfw-default-policy"
  encryption_configuration {
    key_id = aws_kms_key.nfw.arn
    type   = "CUSTOMER_KMS"
  }
  firewall_policy {
    policy_variables {
      rule_variables {
        key = "HOME_NET"
        ip_set {
          definition = var.network_firewall_config.home_net
        }
      }
    }
    stateless_default_actions          = [var.network_firewall_config.stateless_default_actions]
    stateless_fragment_default_actions = [var.network_firewall_config.stateless_fragment_default_actions]
  }
  tags = var.tags
  lifecycle {
    ignore_changes = [
      firewall_policy,
      description
    ]
  }
}

resource "aws_networkfirewall_logging_configuration" "nfw" {
  count = var.network_firewall_config.alert_log == true || var.network_firewall_config.flow_log == true ? 1 : 0

  firewall_arn = aws_networkfirewall_firewall.nfw.arn
  logging_configuration {
    dynamic "log_destination_config" {
      for_each = var.network_firewall_config.alert_log ? { alert = true } : {}
      content {
        log_destination = {
          logGroup = aws_cloudwatch_log_group.alert[0].name
        }
        log_destination_type = "CloudWatchLogs"
        log_type             = "ALERT"
      }
    }
    dynamic "log_destination_config" {
      for_each = var.network_firewall_config.flow_log ? { flow = true } : {}
      content {
        log_destination = {
          logGroup = aws_cloudwatch_log_group.flow[0].name
        }
        log_destination_type = "CloudWatchLogs"
        log_type             = "FLOW"
      }
    }
  }
}

resource "aws_cloudwatch_log_group" "alert" {
  # checkov:skip=CKV_AWS_158:Log group data is always encrypted in CloudWatch Logs. By default, CloudWatch Logs uses server-side encryption for the log data at rest.
  count = var.network_firewall_config.alert_log == true ? 1 : 0

  name              = "/aws/${local.firewall_name}-alerts"
  retention_in_days = 365
}

resource "aws_cloudwatch_log_group" "flow" {
  # checkov:skip=CKV_AWS_158:Log group data is always encrypted in CloudWatch Logs. By default, CloudWatch Logs uses server-side encryption for the log data at rest.
  count = var.network_firewall_config.flow_log == true ? 1 : 0

  name              = "/aws/${local.firewall_name}-logs"
  retention_in_days = 365
}
