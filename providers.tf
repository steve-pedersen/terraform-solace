terraform {
  required_providers {
    solacebroker = {
      source  = "registry.terraform.io/solaceproducts/solacebroker"
      version = "1.0.1"
    }
  }
}

provider "solacebroker" {
  username = var.solace_broker_username
  password = var.solace_broker_password
  url      = var.solace_broker_url
}
