# Copyright Amazon.com, Inc. or its affiliates. All rights reserved.
# SPDX-License-Identifier: Apache-2.0

resource "aws_lambda_function" "aft_new_account_forward_event" {
  # checkov:skip=CKV_AWS_50:This function doesn't need X-Ray for tracing
  # checkov:skip=CKV_AWS_116:This function doesn't need a Dead Letter Queue(DLQ)
  # checkov:skip=CKV_AWS_117:This is a full serveless function doesn't need VPC
  # checkov:skip=CKV_AWS_173:This parameter is not a SecureString and there is no need to encrypt
  # checkov:skip=CKV_AWS_272:This function doesn't need to validate code-signing
  count    = var.use_control_tower_events ? 0 : 1
  provider = aws.aft-management

  filename                       = "${path.module}/lambda/aft-new-account-forward-event.zip"
  function_name                  = "aft-new-account-forward-event"
  description                    = "This Lambda will get the AFT notifications and send the CT event to EventBridge"
  role                           = aws_iam_role.lambda_role[0].arn
  handler                        = "index.lambda_handler"
  source_code_hash               = data.archive_file.aft_new_account_forward_event[0].output_base64sha256
  runtime                        = "python3.12"
  reserved_concurrent_executions = 10
  memory_size                    = 128
  timeout                        = 120
  layers                         = []
  environment {
    variables = {
      EVENT_BUS_ARN = aws_cloudwatch_event_bus.pipeline.arn
    }
  }
}

resource "aws_lambda_permission" "aft_new_account_forward_event" {
  count    = var.use_control_tower_events ? 0 : 1
  provider = aws.aft-management

  statement_id  = "AllowExecutionFromSNS"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.aft_new_account_forward_event[0].function_name
  principal     = "sns.amazonaws.com"
  source_arn    = data.aws_ssm_parameter.aft_sns_notification_topic_arn[0].value
}

resource "aws_sns_topic_subscription" "aft_new_account_forward_event" {
  count    = var.use_control_tower_events ? 0 : 1
  provider = aws.aft-management

  topic_arn           = data.aws_ssm_parameter.aft_sns_notification_topic_arn[0].value
  protocol            = "lambda"
  endpoint            = aws_lambda_function.aft_new_account_forward_event[0].arn
  filter_policy_scope = "MessageBody"
  filter_policy = jsonencode({
    Input = {
      control_tower_event = {
        detail = {
          eventName = [
            "CreateManagedAccount",
            "UpdateManagedAccount"
          ]
        }
      }
    }
    Status = ["SUCCEEDED"]
  })
}
