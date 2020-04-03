# terraform-aws-ses

Create the Amazon SES resource with SNS notification in the sandbox account scenario.

This module will create the following resources:
* Amazon SES - Email addresses with SNS topic notification
* Amazon SNS - Topic and subscription

### Use

```
provider "aws" {
  region = "eu-central-1"
}

module "ses" {
  source = "github.com/lbrealdev/terraform-aws-ses?ref=tf-registry"

  from_mail = "youremailsender@gmail.com"
  to_mail   = "youremailreceiver@gmail.com"
}
```
NOTE: When terraform apply all provisions null_resource will execute aws cli for AWS SNS Subscription. When execute terraform destroy, don't will delete susbcription, necessary make mannually in the console Amazon SNS.