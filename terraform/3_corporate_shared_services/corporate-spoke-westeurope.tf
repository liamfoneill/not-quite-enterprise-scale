resource "azurerm_resource_group" "corporatewesteurope" {
  name     = "spoke-corporate-westeurope"
  location = "West Europe"
}

resource "azurerm_virtual_network" "corporate" {
  name                = "spoke-corporate-westeurope"
  location            = azurerm_resource_group.corporatewesteurope.location
  resource_group_name = azurerm_resource_group.corporatewesteurope.name
  address_space       = ["10.0.12.0/22"]
}