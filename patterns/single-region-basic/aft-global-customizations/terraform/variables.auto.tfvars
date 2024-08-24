securityhub_standards = [
  "arn:aws:securityhub:<region>::standards/aws-foundational-security-best-practices/v/1.0.0",
  # "arn:aws:securityhub:::ruleset/cis-aws-foundations-benchmark/v/1.2.0",
  # "arn:aws:securityhub:<region>::standards/cis-aws-foundations-benchmark/v/1.4.0",
  # "arn:aws:securityhub:<region>::standards/nist-800-53/v/5.0.0",
  # "arn:aws:securityhub:<region>::standards/pci-dss/v/3.2.1"
]

securityhub_control_exceptions = [
  # EXAMPLE
  # {
  #   name    = "aws-foundational-security-best-practices/v/1.0.0/IAM.6"
  #   status  = "DISABLED"
  #   reason  = "No root MFA. SCP prevents root action"
  # },
  # {
  #   name    = "aws-foundational-security-best-practices/v/1.0.0/SNS.1"
  #   status  = "DISABLED"
  #   reason  = "Control Tower does not setup encryption on SNS topics."
  # }
]
