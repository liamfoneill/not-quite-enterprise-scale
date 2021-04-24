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

resource "azurerm_automation_module" "networkingdsc" {
  provider = azurerm.Management
  name                    = "NetworkingDsc"
  resource_group_name     = azurerm_resource_group.automation.name
  automation_account_name = azurerm_automation_account.platform.name
  module_link {
    uri = "https://www.powershellgallery.com/api/v2/package/NetworkingDsc/8.2.0"
  }
}

resource "azurerm_automation_dsc_configuration" "allowPing" {
  provider = azurerm.Management
  name                    = "Allow_Ping"
  resource_group_name     = azurerm_resource_group.automation.name
  automation_account_name = azurerm_automation_account.platform.name
  location                = azurerm_resource_group.automation.location
  content_embedded        = "configuration Allow_Ping {}"
}

resource "azurerm_automation_dsc_nodeconfiguration" "allowPing" {
  provider = azurerm.Management
  name                    = "Allow_Ping.localhost"
  resource_group_name     = azurerm_resource_group.automation.name
  automation_account_name = azurerm_automation_account.platform.name
  depends_on              = [azurerm_automation_dsc_configuration.allowPing]
  content_embedded        = "${file("${path.cwd}/dsc_configurations/allow_ping/localhost.mof")}"
}