resource "azurerm_resource_group" "networkwatcherwesteurope" {
  name     = "connectivity-networkwatcher-westeurope"
  location = "West Europe"
}

resource "azurerm_network_watcher" "westeurope" {
  name                = "westeurope"
  location            = azurerm_resource_group.networkwatcherwesteurope.location
  resource_group_name = azurerm_resource_group.networkwatcherwesteurope.name
}

resource "azurerm_resource_group" "networkwatchernortheurope" {
  name     = "connectivity-networkwatcher-northeurope"
  location = "North Europe"
}

resource "azurerm_network_watcher" "northeurope" {
  name                = "northeurope"
  location            = azurerm_resource_group.networkwatchernortheurope.location
  resource_group_name = azurerm_resource_group.networkwatchernortheurope.name
}