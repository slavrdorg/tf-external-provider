terraform {
  backend "remote" {
    organization = "slavrdorg"
    workspaces {
      name = "test-ext-provider"
    }
  }
}
