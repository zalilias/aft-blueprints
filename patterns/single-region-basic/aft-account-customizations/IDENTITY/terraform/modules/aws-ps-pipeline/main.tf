# Copyright Amazon.com, Inc. or its affiliates. All rights reserved.
# SPDX-License-Identifier: Apache-2.0

resource "aws_codestarconnections_connection" "conn" {
  count = var.use_code_connection ? 1 : 0

  name          = var.code_connection_name
  provider_type = var.code_connection_provider
}

resource "aws_codecommit_repository" "pipeline" {
  count = var.use_code_connection ? 0 : 1

  repository_name = var.repository_name
  description     = "Permission Set Pipeline respository"
  default_branch  = var.main_branch_name
  kms_key_id      = aws_kms_key.cmk.arn
  tags            = var.tags
}

#-------------------------------------------------------------

resource "aws_codebuild_project" "main" {
  name           = "${var.app_name}-build"
  service_role   = aws_iam_role.codebuild_role.arn
  encryption_key = aws_kms_alias.cmk_alias.arn
  artifacts {
    type = "CODEPIPELINE"
  }
  environment {
    compute_type = "BUILD_GENERAL1_SMALL"
    image        = "aws/codebuild/amazonlinux2-x86_64-standard:3.0"
    type         = "LINUX_CONTAINER"
    environment_variable {
      name  = "TF_BUCKET"
      value = aws_s3_bucket.tf_backend.id
    }
    environment_variable {
      name  = "KMS_KEY_ID"
      value = aws_kms_key.cmk.key_id
    }
  }
  source {
    type      = "CODEPIPELINE"
    buildspec = data.local_file.buildspec.content
  }
  logs_config {
    cloudwatch_logs {
      group_name = "/aws/codebuild/${var.app_name}-build"
    }
  }
  tags = var.tags
}

resource "aws_cloudwatch_log_group" "main" {
  name              = "/aws/codebuild/${var.app_name}-build"
  kms_key_id        = aws_kms_key.cmk.arn
  retention_in_days = 365
}

resource "aws_codepipeline" "main" {
  name     = var.app_name
  role_arn = aws_iam_role.codepipeline_role.arn
  artifact_store {
    location = aws_s3_bucket.pipeline.bucket
    type     = "S3"
    encryption_key {
      id   = aws_kms_alias.cmk_alias.arn
      type = "KMS"
    }
  }
  stage {
    name = "Source"
    action {
      name             = "Source"
      category         = "Source"
      owner            = "AWS"
      provider         = var.use_code_connection ? "CodeStarSourceConnection" : "CodeCommit"
      version          = "1"
      output_artifacts = ["main"]
      configuration = var.use_code_connection ? {
        ConnectionArn        = aws_codestarconnections_connection.conn[0].arn
        FullRepositoryId     = var.repository_name
        BranchName           = var.main_branch_name
        OutputArtifactFormat = "CODEBUILD_CLONE_REF"
        } : {
        RepositoryName       = aws_codecommit_repository.pipeline[0].repository_name
        BranchName           = var.test_branch_name
        BranchName           = var.main_branch_name
        PollForSourceChanges = false
        OutputArtifactFormat = "CODE_ZIP"
      }
    }
  }
  stage {
    name = "Build"
    action {
      name            = "Build"
      category        = "Build"
      owner           = "AWS"
      provider        = "CodeBuild"
      version         = "1"
      input_artifacts = ["main"]
      configuration = {
        PrimarySource = "source"
        ProjectName   = aws_codebuild_project.main.name
      }
    }
  }
  tags = var.tags
}

resource "aws_cloudwatch_event_rule" "main" {
  count = var.use_code_connection ? 0 : 1

  name        = "${var.app_name}-main-branch-trigger"
  description = "Rule to trigger the CodePipeline based on code changes"
  event_pattern = jsonencode({
    source      = ["aws.codecommit"]
    detail-type = ["CodeCommit Repository State Change"]
    resources   = [aws_codecommit_repository.pipeline[0].arn]
    detail = {
      event = [
        "referenceCreated",
        "referenceUpdated"
      ]
      referenceType = ["branch"]
      referenceName = [var.main_branch_name]
    }
  })
}

resource "aws_cloudwatch_event_target" "main" {
  count = var.use_code_connection ? 0 : 1

  rule     = aws_cloudwatch_event_rule.main[0].name
  role_arn = aws_iam_role.main.arn
  arn      = aws_codepipeline.main.arn
}

#-------------------------------------------------------------

resource "aws_codebuild_project" "test" {
  count = var.test_branch_name != "" ? 1 : 0

  name           = "${var.app_name}-build-test"
  service_role   = aws_iam_role.codebuild_role.arn
  encryption_key = aws_kms_alias.cmk_alias.arn
  artifacts {
    type = "CODEPIPELINE"
  }
  environment {
    compute_type = "BUILD_GENERAL1_SMALL"
    image        = "aws/codebuild/amazonlinux2-x86_64-standard:3.0"
    type         = "LINUX_CONTAINER"
    environment_variable {
      name  = "TF_BUCKET"
      value = aws_s3_bucket.tf_backend.id
    }
    environment_variable {
      name  = "KMS_KEY_ID"
      value = aws_kms_key.cmk.key_id
    }
  }
  source {
    type      = "CODEPIPELINE"
    buildspec = data.local_file.buildspec.content
  }
  logs_config {
    cloudwatch_logs {
      group_name = "/aws/codebuild/${var.app_name}-build-test"
    }
  }
  tags = var.tags
}

resource "aws_codepipeline" "test" {
  count = var.test_branch_name != "" ? 1 : 0

  name     = "${var.app_name}-test"
  role_arn = aws_iam_role.codepipeline_role.arn
  artifact_store {
    location = aws_s3_bucket.pipeline.bucket
    type     = "S3"
    encryption_key {
      id   = aws_kms_alias.cmk_alias.arn
      type = "KMS"
    }
  }
  stage {
    name = "Source"
    action {
      name             = "Source"
      category         = "Source"
      owner            = "AWS"
      provider         = var.use_code_connection ? "CodeStarSourceConnection" : "CodeCommit"
      version          = "1"
      output_artifacts = ["test"]
      configuration = var.use_code_connection ? {
        ConnectionArn        = aws_codestarconnections_connection.conn[0].arn
        FullRepositoryId     = var.repository_name
        BranchName           = var.test_branch_name
        OutputArtifactFormat = "CODEBUILD_CLONE_REF"
        } : {
        RepositoryName       = aws_codecommit_repository.pipeline[0].repository_name
        BranchName           = var.test_branch_name
        PollForSourceChanges = false
        OutputArtifactFormat = "CODE_ZIP"
      }
    }
  }
  stage {
    name = "Build"
    action {
      name            = "Build"
      category        = "Build"
      owner           = "AWS"
      provider        = "CodeBuild"
      version         = "1"
      input_artifacts = ["test"]
      configuration = {
        PrimarySource = "source"
        ProjectName   = aws_codebuild_project.test[0].name
      }
    }
  }
  tags = var.tags
}

resource "aws_cloudwatch_log_group" "test" {
  count = var.test_branch_name != "" ? 1 : 0

  name              = "/aws/codebuild/${var.app_name}-build-test"
  kms_key_id        = aws_kms_key.cmk.arn
  retention_in_days = 365
}

resource "aws_cloudwatch_event_rule" "test" {
  count = var.test_branch_name != "" && var.use_code_connection == false ? 1 : 0

  name        = "${var.app_name}-test-branch-trigger"
  description = "Rule to trigger the CodePipeline based on code changes"
  event_pattern = jsonencode({
    source      = ["aws.codecommit"]
    detail-type = ["CodeCommit Repository State Change"]
    resources   = [aws_codecommit_repository.pipeline[0].arn]
    detail = {
      event = [
        "referenceCreated",
        "referenceUpdated"
      ]
      referenceType = ["branch"]
      referenceName = [var.test_branch_name]
    }
  })
}

resource "aws_cloudwatch_event_target" "test" {
  count = var.test_branch_name != "" && var.use_code_connection == false ? 1 : 0

  rule     = aws_cloudwatch_event_rule.test[0].name
  role_arn = aws_iam_role.test[0].arn
  arn      = aws_codepipeline.test[0].arn
}

