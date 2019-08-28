terraform {
  backend "remote" {
    hostname = "app.terraform.io"
    organization = "slavrdorg"

    workspaces {
      name = "tf-external-provider"
    }
  }
}
