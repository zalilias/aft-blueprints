# Copyright Amazon.com, Inc. or its affiliates. All rights reserved.
# SPDX-License-Identifier: Apache-2.0

variable "use_code_connection" {
  description = <<-EOF
    "Whether to use a code connection for external VCS (e.g. GitHub). 
    If false, the code will try to create a CodeCommit repository. 
    As AWS CodeCommit is no longer available to new customers, make sure your account has access to the service."
  EOF
  type        = bool
  default     = true
}

variable "repository_name" {
  description = "Repository name for AWS Permission Set pipeline. For external VCS, inform the full repository path (e.g. GitHubOrganization/repository-name)."
  type        = string
  default     = "myorg/aws-ps-pipeline"
}

variable "branch_name" {
  description = "Repository main branch name for AWS Permission Set pipeline."
  type        = string
  default     = "main"
}
