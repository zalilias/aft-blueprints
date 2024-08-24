
variable "enable_standards" {
  description = "List of Security Hub Standards to enable"
  type        = list(string)
  default     = []
  #   "arn:aws:securityhub:<region>::standards/aws-foundational-security-best-practices/v/1.0.0",
  #   # "arn:aws:securityhub:::ruleset/cis-aws-foundations-benchmark/v/1.2.0",
  #   # "arn:aws:securityhub:<region>::standards/cis-aws-foundations-benchmark/v/1.4.0",
  #   # "arn:aws:securityhub:<region>::standards/nist-800-53/v/5.0.0",
  #   # "arn:aws:securityhub:<region>::standards/pci-dss/v/3.2.1"
  # ]
}

variable "control_exceptions" {
  description = "List of Security Hub Checks to enable/disable"
  type = list(object({
    name   = string
    status = string
    reason = string
  }))
  default = []
}
