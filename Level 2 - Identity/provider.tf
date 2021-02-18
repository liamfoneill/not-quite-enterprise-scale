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
  
subscription_id = "1636c70c-ca72-4b17-8981-00e68cb540f8"
}