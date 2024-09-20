# Copyright Amazon.com, Inc. or its affiliates. All rights reserved.
# SPDX-License-Identifier: Apache-2.0

resource "aws_iam_role" "main" {
  name_prefix        = "${var.app_name}-main-trigger-role"
  assume_role_policy = file("${path.module}/assets/trust-policies/events.json")
  inline_policy {
    name = "StartPipeline"
    policy = jsonencode({
      Version = "2012-10-17"
      Statement = [
        {
          Action   = ["codepipeline:StartPipelineExecution"]
          Effect   = "Allow"
          Resource = aws_codepipeline.main.arn
        }
      ]
    })
  }
}

resource "aws_iam_role" "test" {
  count = var.test_branch_name != "" ? 1 : 0

  name_prefix        = "${var.app_name}-test-trigger-role"
  assume_role_policy = file("${path.module}/assets/trust-policies/events.json")
  inline_policy {
    name = "StartPipeline"
    policy = jsonencode({
      Version = "2012-10-17"
      Statement = [
        {
          Action   = ["codepipeline:StartPipelineExecution"]
          Effect   = "Allow"
          Resource = aws_codepipeline.test[0].arn
        }
      ]
    })
  }
}

resource "aws_iam_role" "codebuild_role" {
  name                  = "${var.app_name}-codebuild-role"
  assume_role_policy    = file("${path.module}/assets/trust-policies/codebuild.json")
  force_detach_policies = true
}

resource "aws_iam_role_policy" "codebuild_policy" {
  name = "${var.app_name}-codebuild-policy"
  role = aws_iam_role.codebuild_role.id
  policy = templatefile("${path.module}/assets/role-policies/codebuild_role_policy.json", {
    region                = data.aws_region.current.name
    account_id            = data.aws_caller_identity.current.account_id
    app_name              = var.app_name
    pipeline_bucket_arn   = aws_s3_bucket.pipeline.arn
    tf_backend_bucket_arn = aws_s3_bucket.tf_backend.arn
  })
}

resource "aws_iam_role_policy" "codebuild_identity_center_policy" {
  name   = "IdentityCenterPolicy"
  role   = aws_iam_role.codebuild_role.id
  policy = file("${path.module}/assets/role-policies/identity_center_role_policy.json")
}

resource "aws_iam_role" "codepipeline_role" {
  name                  = "${var.app_name}-codepipeline-role"
  assume_role_policy    = file("${path.module}/assets/trust-policies/codepipeline.json")
  force_detach_policies = true
}

resource "aws_iam_role_policy" "codepipeline_policy" {
  name = "${var.app_name}-codepipeline-policy"
  role = aws_iam_role.codepipeline_role.id
  policy = templatefile("${path.module}/assets/role-policies/codepipeline_role_policy.json", {
    region              = data.aws_region.current.name
    account_id          = data.aws_caller_identity.current.account_id
    app_name            = var.app_name
    pipeline_bucket_arn = aws_s3_bucket.pipeline.arn
  })
}

resource "aws_iam_role_policy" "codepipeline_code_connection_policy" {
  count = var.use_code_connection ? 1 : 0

  name = "CodeConnectionPolicy"
  role = aws_iam_role.codepipeline_role.id
  policy = templatefile("${path.module}/assets/role-policies/code_connection_role_policy.json", {
    code_connection_arn = aws_codestarconnections_connection.conn[0].arn
  })
}

resource "aws_iam_role_policy" "codepipeline_codecommit_policy" {
  count = var.use_code_connection ? 0 : 1

  name = "CodecommitPolicy"
  role = aws_iam_role.codepipeline_role.id
  policy = templatefile("${path.module}/assets/role-policies/codecommit_role_policy.json", {
    codecommit_arn = aws_codecommit_repository.pipeline[0].arn
  })
}

resource "aws_iam_role" "lambda_role" {
  count    = var.use_control_tower_events ? 0 : 1
  provider = aws.aft-management
  
  name                  = "${var.app_name}-lambda-role"
  assume_role_policy    = file("${path.module}/assets/trust-policies/lambda.json")
  force_detach_policies = true
}

resource "aws_iam_role_policy" "lambda_policy" {
  count    = var.use_control_tower_events ? 0 : 1
  provider = aws.aft-management

  name = "${var.app_name}-lambda-policy"
  role = aws_iam_role.lambda_role[0].id
  policy = templatefile("${path.module}/assets/role-policies/lambda_role_policy.json", {
    region        = data.aws_region.current.name
    account_id    = data.aws_ssm_parameter.aft_management_account_id[0].value
    event_bus_arn = aws_cloudwatch_event_bus.pipeline.arn
  })
}