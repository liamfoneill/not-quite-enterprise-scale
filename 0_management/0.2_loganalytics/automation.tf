resource "azurerm_resource_group" "automation" {
  provider = azurerm.Management
  name     = "management-automation-001"
  location = "West Europe"
  tags = {
    "Usage" = "Azure Automation"
  }
}

# Automation Account
resource "azurerm_automation_account" "platform" {
  provider = azurerm.Management
  name                = "buildingazure-management-automation-001"
  location            = azurerm_resource_group.automation.location
  resource_group_name = azurerm_resource_group.automation.name
  sku_name = "Basic"
}

resource "azurerm_monitor_diagnostic_setting" "automation" {
  provider = azurerm.Management
  name               = "Management-Logs"
  target_resource_id = azurerm_automation_account.platform.id
  log_analytics_workspace_id = azurerm_log_analytics_workspace.platform.id

  log {
    category = "JobLogs"
    enabled  = true

    retention_policy {
      enabled = false
    }
  }
    log {
    category = "JobStreams"
    enabled  = true

    retention_policy {
      enabled = false
    }
  }

    log {
    category = "DscNodeStatus"
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