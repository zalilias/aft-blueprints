
resource "aws_securityhub_standards_subscription" "standard" {
  for_each      = toset(var.enable_standards)
  standards_arn = replace(each.key, "<region>", "${data.aws_region.current.name}")
}

resource "aws_securityhub_standards_control" "control" {
  depends_on = [aws_securityhub_standards_subscription.standard]
  for_each = {
    for control in var.control_exceptions : control.name => control
  }
  standards_control_arn = "arn:aws:securityhub:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:control/${each.value.name}"
  control_status        = each.value.status
  disabled_reason       = each.value.reason
}
