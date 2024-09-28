# Copyright Amazon.com, Inc. or its affiliates. All rights reserved.
# SPDX-License-Identifier: Apache-2.0

variable "solution_name" {
  description = "Solution name."
  type        = string
  default     = "aws-ps-pipeline"
}

variable "repository_name" {
  description = "VCS repository name. For external VCS, inform the full repository path (e.g. GitHubOrganization/repository-name)."
  type        = string
  default     = "aws-ps-pipeline"
}

variable "branch_name" {
  description = "Repository main branch name."
  type        = string
  default     = "main"
}

variable "use_code_connection" {
  description = "Whether to use a code connection for external VCS (e.g GitHub)"
  type        = bool
  default     = true
}

variable "code_connection_name" {
  description = "Code connection name"
  type        = string
  default     = "aws-ps-pipeline-connection"
}

variable "code_connection_provider" {
  description = "Code connection provider"
  type        = string
  default     = "GitHub"
  validation {
    condition     = contains(["GitHub"], var.code_connection_provider)
    error_message = "Valid values for code_connection_provider are: GitHub"
  }
}

variable "account_lifecyle_events_source" {
  description = "Define from where to capture account lifecycle events: AFT or Control Tower (CT)."
  type        = string
  default     = "AFT"
  validation {
    condition     = contains(["AFT", "CT"], var.account_lifecyle_events_source)
    error_message = "Valid values for account_lifecyle_events_source are: AFT or CT"
  }
}

variable "tags" {
  type    = map(string)
  default = {}
}
