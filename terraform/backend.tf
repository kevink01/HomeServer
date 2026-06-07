terraform {
  backend "local" {
    path = "/mnt/user/appdata/terraform/terraform.tfstate"
  }
  required_providers {
    uptimekuma = {
      source  = "breml/uptimekuma"
      version = "~> 0.3.2"
    }
  }
}
