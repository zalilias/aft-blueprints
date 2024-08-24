#!/bin/bash
# Copyright Amazon.com, Inc. or its affiliates. All rights reserved.
# SPDX-License-Identifier: Apache-2.0
#

# Disclaimer: This shell script is being used as a workaround. There is currently no
# Terraform resource available to perform this specific task.

echo "Executing Pre-API Helpers"

#Enforce AWS Backup service trusted access for AWS Organizations
aws organizations enable-aws-service-access --service-principal "backup.amazonaws.com" --profile ct-management

# Check if BACKUP_POLICY is already enabled at organization level
backup_policy=$(aws organizations list-roots --query 'Roots[].PolicyTypes[?(Type==`BACKUP_POLICY`)].Status' --output text --profile ct-management)

if [ "$backup_policy" = "ENABLED" ]; then
    echo "BACKUP_POLICY is already enabled"
    exit 0
else
    echo "Enabling BACKUP_POLICY at organization level"
    aws organizations enable-policy-type --policy-type BACKUP_POLICY --root-id $(aws organizations list-roots --query 'Roots[].Id' --output text --profile ct-management) --profile ct-management
    exit 0
fi
exit 1
