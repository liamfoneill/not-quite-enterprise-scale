resource "azurerm_resource_group" "automation" {
  name     = "platform-automation-001"
  location = "West Europe"
  tags = {
    "Usage" = "Azure Automation"
  }
}

# Automation Account
resource "azurerm_automation_account" "platform" {
  name                = "buildingazure-platform-automation-001"
  location            = azurerm_resource_group.automation.location
  resource_group_name = azurerm_resource_group.automation.name
  sku_name = "Basic"
}