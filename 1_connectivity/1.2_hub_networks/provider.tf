# Configure the Azure provider
terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = ">= 2.26"
    }
  }
}

provider "azurerm" {
  features {}
  alias = "Connectivity"
  subscription_id = "0c620453-b984-4e82-b9cf-1e6fb9992c1e"
}

provider "azurerm" {
  features {}
  alias = "Management"
  subscription_id = "1636c70c-ca72-4b17-8981-00e68cb540f8"
}

provider "azurerm" {
  features {}
  alias = "Identity"
  subscription_id = "7a59ed2c-6791-4fa3-9d5c-4f7322726284"
}

provider "azurerm" {
  features {}
  alias = "Corporate"
  subscription_id = "d0930a27-6dec-477a-85f9-13734db2f0ca"
}
provider "azurerm" {
  features {}
  alias = "Online"
  subscription_id = "0564194e-173f-4686-b1e4-8599dbf3fd7f"
}

provider "azurerm" {
  features {}
  alias = "Manufacturing"
  subscription_id = "a8d89de8-d014-4deb-81f8-cecb19fbe41d"
}

provider "azurerm" {
  features {}
  alias = "Sandbox"
  subscription_id = "f1802194-fb29-4974-a84d-132574cb73a0"
}