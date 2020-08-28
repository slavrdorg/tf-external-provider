provider "okta" {
  version  = "~> 3.0"
  org_name = "dummyorg"
  api_token = "not_a_valid_token"
}

terraform {
  required_version = "~> 0.12.0"
}
