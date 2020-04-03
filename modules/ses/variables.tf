# ---------------------------------------------------------------------------------------------------------------------
# REQUIRED PARAMETERS
# You must provide a value for each of these parameters.
# ---------------------------------------------------------------------------------------------------------------------

variable "create" {
  type    = bool
  default = true
}

variable "name" {
  description = "The friendly name for the SNS topic."
  type        = string
  default     = "topic-ses"
}

variable "display_name" {
  description = "The display name for the SNS topic."
  type        = string
  default     = "Topic to bounce complaint and delivery notifications for Aws SES DEV Caucion"
}

variable "delivery_policy" {
  description = "The SNS delivery policy."
  type        = string
  default     = <<EOF
{
  "http": {
    "defaultHealthyRetryPolicy": {
      "minDelayTarget": 20,
      "maxDelayTarget": 20,
      "numRetries": 3,
      "numMaxDelayRetries": 0,
      "numNoDelayRetries": 0,
      "numMinDelayRetries": 0,
      "backoffFunction": "linear"
    },
    "disableSubscriptionOverrides": false,
    "defaultThrottlePolicy": {
      "maxReceivesPerSecond": 1
    }
  }
}
EOF
}

variable "protocol" {
  type    = string
  default = "email"
}

variable "email_identity" {
  description = "The email address to assign to SES."
  type        = map(string)
  default     = null
}

variable "notification_type" {
  description = "The type of notifications that will be published to the specified Amazon SNS topic. Valid Values: `Bounce`, `Complaint` or `Delivery`"
  type        = map(string)
  default = {
    bounce    = "Bounce"
    complaint = "Complaint"
    delivery  = "Delivery"
  }
}
