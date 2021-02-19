data "azurerm_log_analytics_workspace" "platform" {
  provider = azurerm.Management
  name                = "buildingazure-management-logs-001"
  resource_group_name = "management-logging-001"
}

resource "azurerm_resource_group" "storage" {
  provider = azurerm.Management
  name     = "management-storage-001"
  location = "West Europe"
  tags = {
    "Usage" = "Storage"
  }
}

data "azurerm_client_config" "current" {
  provider = azurerm.Management
}

# Key Vault
resource "azurerm_key_vault" "platform" {
  provider = azurerm.Management
  name                        = "buildingazuremanagement"
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

resource "azurerm_monitor_diagnostic_setting" "keyvault" {
  provider = azurerm.Management
  name               = "Management-Logs"
  target_resource_id =  azurerm_key_vault.platform.id
  log_analytics_workspace_id = data.azurerm_log_analytics_workspace.platform.id

  log {
    category = "AuditEvent"
    enabled  = true

    retention_policy {
      enabled = false
    }
  }
  
  metric {
    category = "AllMetrics"

    retention_policy {
      enabled = false
    }
  }
}

# Storage Account for Terraform State Files
resource "azurerm_storage_account" "terraformstate" {
  provider = azurerm.Management
  name                     = "buildingazuretfstate"
  resource_group_name      = azurerm_resource_group.storage.name
  location                 = azurerm_resource_group.storage.location
  account_tier             = "Standard"
  account_replication_type = "GRS"

  tags = {
    Usage = "Terraform State Files"
  }
}
resource "azurerm_monitor_diagnostic_setting" "terraformstate_storageaccount" {
  provider = azurerm.Management
  name               = "Management-Logs"
  target_resource_id =  azurerm_storage_account.terraformstate.id
  log_analytics_workspace_id = data.azurerm_log_analytics_workspace.platform.id
  
  metric {
    category = "Transaction"

    retention_policy {
      enabled = false
    }
  }
}
# Storage Account for Cloud Shell
resource "azurerm_storage_account" "cloudshell" {
  provider = azurerm.Management
  name                     = "buildingazurecloudshell"
  resource_group_name      = azurerm_resource_group.storage.name
  location                 = azurerm_resource_group.storage.location
  account_tier             = "Standard"
  account_replication_type = "GRS"

  tags = {
    Usage = "Cloud Shell Storage"
  }
}
resource "azurerm_monitor_diagnostic_setting" "cloudshell_storageaccount" {
  provider = azurerm.Management
  name               = "Management-Logs"
  target_resource_id =  azurerm_storage_account.cloudshell.id
  log_analytics_workspace_id = data.azurerm_log_analytics_workspace.platform.id
  
  metric {
    category = "Transaction"

    retention_policy {
      enabled = false
    }
  }
}

# Storage Account for NSG Flow Logs West Europe
resource "azurerm_resource_group" "nsgflowlogs_westeurope" {
  provider = azurerm.Management
  name     = "management-nsgflowlogs-westeurope-001"
  location = "West Europe"
  tags = {
    "Usage" = "NSG Flow Logs"
  }
}

resource "azurerm_storage_account" "nsgflowlogs_westeurope" {
  provider = azurerm.Management
  name                     = "bansgflowlogswe"
  resource_group_name      = azurerm_resource_group.nsgflowlogs_westeurope.name
  location                 = azurerm_resource_group.nsgflowlogs_westeurope.location
  account_tier             = "Standard"
  account_replication_type = "GRS"

  tags = {
    Usage = "NSG Flow Logs"
  }
}
resource "azurerm_monitor_diagnostic_setting" "nsgflowlogs_westeurope_storageaccount" {
  provider = azurerm.Management
  name               = "Management-Logs"
  target_resource_id =  azurerm_storage_account.nsgflowlogs_westeurope.id
  log_analytics_workspace_id = data.azurerm_log_analytics_workspace.platform.id
  
  metric {
    category = "Transaction"

    retention_policy {
      enabled = false
    }
  }
}

resource "azurerm_resource_group" "nsgflowlogs_northeurope" {
  provider = azurerm.Management
  name     = "management-nsgflowlogs-northeurope-001"
  location = "North Europe"
  tags = {
    "Usage" = "NSG Flow Logs"
  }
}

resource "azurerm_storage_account" "nsgflowlogs_northeurope" {
  provider = azurerm.Management
  name                     = "bansgflowlogsne"
  resource_group_name      = azurerm_resource_group.nsgflowlogs_northeurope.name
  location                 = azurerm_resource_group.nsgflowlogs_northeurope.location
  account_tier             = "Standard"
  account_replication_type = "GRS"

  tags = {
    Usage = "NSG Flow Logs"
  }
}

resource "azurerm_monitor_diagnostic_setting" "nsgflowlogs_northeurope_storageaccount" {
  provider = azurerm.Management
  name               = "Management-Logs"
  target_resource_id =  azurerm_storage_account.nsgflowlogs_northeurope.id
  log_analytics_workspace_id = data.azurerm_log_analytics_workspace.platform.id
  
  metric {
    category = "Transaction"

    retention_policy {
      enabled = false
    }
  }
}