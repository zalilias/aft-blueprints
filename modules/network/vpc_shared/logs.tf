# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
# SPDX-License-Identifier: Apache-2.0

resource "aws_flow_log" "log" {
  count = var.enable_flow_log ? 1 : 0

  iam_role_arn    = aws_iam_role.log[0].arn
  log_destination = aws_cloudwatch_log_group.log[0].arn
  traffic_type    = "ALL"
  vpc_id          = aws_vpc.this.id
  tags            = var.tags
}

resource "aws_cloudwatch_log_group" "log" {
  # checkov:skip=CKV_AWS_158:Log group data is always encrypted in CloudWatch Logs. By default, CloudWatch Logs uses server-side encryption for the log data at rest.
  count = var.enable_flow_log ? 1 : 0

  name              = "${local.vpc_name}-flow-logs"
  retention_in_days = 365
  tags              = var.tags
}

resource "aws_iam_role" "log" {
  count = var.enable_flow_log ? 1 : 0

  name_prefix = "${local.vpc_name}-flow-logs-role-"
  assume_role_policy = jsonencode(
    {
      Version = "2012-10-17"
      Statement = [
        {
          Effect = "Allow"
          Action = "sts:AssumeRole"
          Principal = {
            Service = "vpc-flow-logs.amazonaws.com"
          }
        }
      ]
    }
  )
  inline_policy {
    name = "PutEventsPolicy"
    policy = jsonencode(
      {
        Version = "2012-10-17"
        Statement = [
          {
            Effect = "Allow"
            Action = [
              "logs:CreateLogStream",
              "logs:PutLogEvents",
              "logs:DescribeLogGroups",
              "logs:DescribeLogStreams",
              "logs:CreateLogGroup"
            ]
            Resource = [aws_cloudwatch_log_group.log[0].arn]
          }
        ]
    })
  }
  tags = var.tags
}
