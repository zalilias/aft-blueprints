#!/bin/bash
# Copyright Amazon.com, Inc. or its affiliates. All rights reserved.
# SPDX-License-Identifier: Apache-2.0
#

echo "Executing Pre-API Helpers"

# Disclaimer: This shell script is being used as a workaround. There is currently no
# Terraform resource available to perform this specific task.

echo "Executing Pre-API Helpers"

#Enforce IAM Access Analyzer service trusted access for AWS Organizations
aws organizations enable-aws-service-access --service-principal "access-analyzer.amazonaws.com" --profile ct-management

sleep 5

#Enforce IAM Access Analyzer service linked role creation
aws iam create-service-linked-role --aws-service-name access-analyzer.amazonaws.com --profile ct-management >/dev/null 2>&1 || false