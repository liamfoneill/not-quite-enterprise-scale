resource "azurerm_resource_group" "identitywesteurope" {
  name     = "spoke-identity-westeurope"
  location = "West Europe"
  tags = {
    "Usage" = "Active Directory Domain Controllers"
  }
}

resource "azurerm_virtual_network" "identity" {
  name                = "spoke-identity-westeurope"
  location            = azurerm_resource_group.identitywesteurope.location
  resource_group_name = azurerm_resource_group.identitywesteurope.name
  address_space       = ["10.0.4.0/22"]
}