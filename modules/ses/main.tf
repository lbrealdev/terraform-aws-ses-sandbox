# ---------------------------------------------------------------------------------------------------------------------
# THESE TEMPLATES REQUIRE TERRAFORM VERSION 0.12 AND ABOVE
# ---------------------------------------------------------------------------------------------------------------------

terraform {
  required_version = "~> 0.12"
}

# ---------------------------------------------------------------------------------------------------------------------
# This feature depends on topic_subscription to be complete.
# When provided by Terraform, it does not support email protocol.
# ---------------------------------------------------------------------------------------------------------------------

resource "aws_sns_topic" "main" {
  count = var.create ? 1 : 0

  name            = var.name
  display_name    = var.display_name
  delivery_policy = var.delivery_policy

  tags = {
    Description = "Managed by Terraform"
  }
}

resource "null_resource" "main" {
  count = var.create ? length(aws_sns_topic.main) : 0

  provisioner "local-exec" {
    command = "aws sns subscribe --topic-arn ${aws_sns_topic.main[count.index].arn} --protocol ${var.protocol} --notification-endpoint ${aws_ses_email_identity.main["main_email"].email}"
  }

  depends_on = [aws_sns_topic.main]
}

resource "aws_ses_email_identity" "main" {
  for_each = var.email_identity

  email = each.value
}

resource "aws_ses_identity_notification_topic" "main" {
  for_each = var.notification_type

  identity                 = aws_ses_email_identity.main["main_email"].arn
  topic_arn                = aws_sns_topic.main[0].arn
  notification_type        = each.value
  include_original_headers = true

  depends_on = [
    aws_sns_topic.main,
    aws_ses_email_identity.main
  ]
}
