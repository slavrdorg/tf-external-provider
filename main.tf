provider "okta" {
  org_name = "dummyorg"
  api_token = "not_a_valid_token"
}

terraform {
  required_version = ">= 0.13.0"
  required_providers {
    okta = {
      source = "providers.local/local/okta"
      version = "~> 3.0"
    }
  }
}
