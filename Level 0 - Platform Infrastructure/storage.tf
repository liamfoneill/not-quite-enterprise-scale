resource "azurerm_resource_group" "storage" {
  name     = "platform-storage-001"
  location = "West Europe"
  tags = {
    "Usage" = "Storage"
  }
}

data "azurerm_client_config" "current" {}

# Key Vault
resource "azurerm_key_vault" "platform" {
  name                        = "buildingazureplatform"
  location                    = azurerm_resource_group.storage.location
  resource_group_name         = azurerm_resource_group.storage.name
  enabled_for_deployment = true
  enabled_for_disk_encryption = true
  enabled_for_template_deployment = true
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  sku_name = "standard"
}

#Storage Account for Terraform State Files
resource "azurerm_storage_account" "terraformstate" {
  name                     = "buildingazuretfstate"
  resource_group_name      = azurerm_resource_group.storage.name
  location                 = azurerm_resource_group.storage.location
  account_tier             = "Standard"
  account_replication_type = "GRS"

  tags = {
    Usage = "Terraform State Files"
  }
}
# Storage Account for Cloud Shell
resource "azurerm_storage_account" "cloudshell" {
  name                     = "buildingazurecloudshell"
  resource_group_name      = azurerm_resource_group.storage.name
  location                 = azurerm_resource_group.storage.location
  account_tier             = "Standard"
  account_replication_type = "GRS"

  tags = {
    Usage = "Cloud Shell Storage"
  }
}