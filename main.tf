# ----------------------------------------------------------------------------------------------------------------------
# REQUIRE A SPECIFIC TERRAFORM VERSION OR HIGHER
# This module has been updated with 0.12 syntax, which means it is no longer compatible with any versions below 0.12.
# ----------------------------------------------------------------------------------------------------------------------

module "ses" {
  source = "./modules/ses"

  email_identity = {
    main_email = var.from_mail,
    test_email = var.to_mail
  }
}
