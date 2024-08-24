# Copyright Amazon.com, Inc. or its affiliates. All rights reserved.
# SPDX-License-Identifier: Apache-2.0

variable "app_name" {
  description = "Solution/Application name prefix."
  type        = string
  default     = "aws-ps-pipeline"
}

variable "repository_name" {
  description = "VCS repository name. For external VCS, inform the full repository path (e.g. GitHubOrganization/repository-name)"
  type        = string
  default     = "aws-ps-pipeline"
}

variable "main_branch_name" {
  description = "Repository main branch name."
  type        = string
  default     = "main"
}

variable "test_branch_name" {
  description = "Repository branch name. If defined, it creates a test pipeline to validate the permission sets ('terraform plan') only"
  type        = string
  default     = ""
}

variable "use_control_tower_events" {
  description = "Whether to use Control Tower events, to run the pipeline"
  type        = bool
  default     = false
}

variable "use_code_connection" {
  description = "Whether to use a code connection for external VCS (e.g GitHub)"
  type        = bool
  default     = false
}

variable "code_connection_name" {
  description = "Code connection name"
  type        = string
  default     = "aws-ps-pipeline"
}

variable "code_connection_provider" {
  description = "Code connection provider"
  type        = string
  default     = "GitHub"
  validation {
    condition     = contains(["GitHub"], var.code_connection_provider)
    error_message = "The code connection provider is invalid."
  }
}

variable "tags" {
  type    = map(string)
  default = {}
}
