resource "azurerm_resource_group" "logging" {
  provider = azurerm.Management
  name     = "management-logging-001"
  location = "West Europe"
  tags = {
    "Usage" = "Log Analytics"
  }
}

# Log Analytics Workspace
resource "azurerm_log_analytics_workspace" "platform" {
  provider = azurerm.Management
  name                = "buildingazure-management-logs-001"
  location            = azurerm_resource_group.logging.location
  resource_group_name = azurerm_resource_group.logging.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
  daily_quota_gb = 1
  internet_ingestion_enabled = true
  internet_query_enabled = true
}

resource "azurerm_monitor_diagnostic_setting" "log_analytics" {
  provider = azurerm.Management
  name               = "Management-Logs"
  target_resource_id = azurerm_log_analytics_workspace.platform.id
  log_analytics_workspace_id = azurerm_log_analytics_workspace.platform.id

  log {
    category = "Audit"
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

# Link Between Automation Account and Log Analytics
resource "azurerm_log_analytics_linked_service" "platform" {
  provider = azurerm.Management
  resource_group_name = azurerm_resource_group.logging.name
  workspace_id        = azurerm_log_analytics_workspace.platform.id
  read_access_id      = azurerm_automation_account.platform.id
}
# Log Analytics Solutions
#Container Insights
resource "azurerm_log_analytics_solution" "containerinsights" {
  provider = azurerm.Management
  solution_name         = "ContainerInsights"
  location              = azurerm_resource_group.logging.location
  resource_group_name   = azurerm_resource_group.logging.name
  workspace_resource_id = azurerm_log_analytics_workspace.platform.id
  workspace_name        = azurerm_log_analytics_workspace.platform.name

  plan {
    publisher = "Microsoft"
    product   = "OMSGallery/ContainerInsights"
  }
}
#ServiceMap
resource "azurerm_log_analytics_solution" "servicemap" {
  provider = azurerm.Management
  solution_name         = "ServiceMap"
  location              = azurerm_resource_group.logging.location
  resource_group_name   = azurerm_resource_group.logging.name
  workspace_resource_id = azurerm_log_analytics_workspace.platform.id
  workspace_name        = azurerm_log_analytics_workspace.platform.name

  plan {
    publisher = "Microsoft"
    product   = "OMSGallery/ServiceMap"
  }
}
#AzureActivity
resource "azurerm_log_analytics_solution" "azureactivity" {
  provider = azurerm.Management
  solution_name         = "AzureActivity"
  location              = azurerm_resource_group.logging.location
  resource_group_name   = azurerm_resource_group.logging.name
  workspace_resource_id = azurerm_log_analytics_workspace.platform.id
  workspace_name        = azurerm_log_analytics_workspace.platform.name

  plan {
    publisher = "Microsoft"
    product   = "OMSGallery/AzureActivity"
  }
}
#ChangeTracking
resource "azurerm_log_analytics_solution" "changetracking" {
  provider = azurerm.Management
  solution_name         = "ChangeTracking"
  location              = azurerm_resource_group.logging.location
  resource_group_name   = azurerm_resource_group.logging.name
  workspace_resource_id = azurerm_log_analytics_workspace.platform.id
  workspace_name        = azurerm_log_analytics_workspace.platform.name

  plan {
    publisher = "Microsoft"
    product   = "OMSGallery/ChangeTracking"
  }
}
#VMInsights
resource "azurerm_log_analytics_solution" "vminsights" {
  provider = azurerm.Management
  solution_name         = "VMInsights"
  location              = azurerm_resource_group.logging.location
  resource_group_name   = azurerm_resource_group.logging.name
  workspace_resource_id = azurerm_log_analytics_workspace.platform.id
  workspace_name        = azurerm_log_analytics_workspace.platform.name

  plan {
    publisher = "Microsoft"
    product   = "OMSGallery/VMInsights"
  }
}
#SecurityInsights
resource "azurerm_log_analytics_solution" "securityinsights" {
  provider = azurerm.Management
  solution_name         = "SecurityInsights"
  location              = azurerm_resource_group.logging.location
  resource_group_name   = azurerm_resource_group.logging.name
  workspace_resource_id = azurerm_log_analytics_workspace.platform.id
  workspace_name        = azurerm_log_analytics_workspace.platform.name

  plan {
    publisher = "Microsoft"
    product   = "OMSGallery/SecurityInsights"
  }
}
#NetworkMonitoring
resource "azurerm_log_analytics_solution" "networkmonitoring" {
  provider = azurerm.Management
  solution_name         = "NetworkMonitoring"
  location              = azurerm_resource_group.logging.location
  resource_group_name   = azurerm_resource_group.logging.name
  workspace_resource_id = azurerm_log_analytics_workspace.platform.id
  workspace_name        = azurerm_log_analytics_workspace.platform.name

  plan {
    publisher = "Microsoft"
    product   = "OMSGallery/NetworkMonitoring"
  }
}
#SQLVulnerabilityAssessment
resource "azurerm_log_analytics_solution" "sqlvulnerabilityassessment" {
  provider = azurerm.Management
  solution_name         = "SQLVulnerabilityAssessment"
  location              = azurerm_resource_group.logging.location
  resource_group_name   = azurerm_resource_group.logging.name
  workspace_resource_id = azurerm_log_analytics_workspace.platform.id
  workspace_name        = azurerm_log_analytics_workspace.platform.name

  plan {
    publisher = "Microsoft"
    product   = "OMSGallery/SQLVulnerabilityAssessment"
  }
}
#SQLAdvancedThreatProtection
resource "azurerm_log_analytics_solution" "sqldvancedthreatprotection" {
  provider = azurerm.Management
  solution_name         = "SQLAdvancedThreatProtection"
  location              = azurerm_resource_group.logging.location
  resource_group_name   = azurerm_resource_group.logging.name
  workspace_resource_id = azurerm_log_analytics_workspace.platform.id
  workspace_name        = azurerm_log_analytics_workspace.platform.name

  plan {
    publisher = "Microsoft"
    product   = "OMSGallery/SQLAdvancedThreatProtection"
  }
}
#AntiMalware
resource "azurerm_log_analytics_solution" "antimalware" {
  provider = azurerm.Management
  solution_name         = "AntiMalware"
  location              = azurerm_resource_group.logging.location
  resource_group_name   = azurerm_resource_group.logging.name
  workspace_resource_id = azurerm_log_analytics_workspace.platform.id
  workspace_name        = azurerm_log_analytics_workspace.platform.name

  plan {
    publisher = "Microsoft"
    product   = "OMSGallery/AntiMalware"
  }
}
#AzureAutomation
resource "azurerm_log_analytics_solution" "azureautomation" {
  provider = azurerm.Management
  solution_name         = "AzureAutomation"
  location              = azurerm_resource_group.logging.location
  resource_group_name   = azurerm_resource_group.logging.name
  workspace_resource_id = azurerm_log_analytics_workspace.platform.id
  workspace_name        = azurerm_log_analytics_workspace.platform.name

  plan {
    publisher = "Microsoft"
    product   = "OMSGallery/AzureAutomation"
  }
}
#LogicAppsManagement
resource "azurerm_log_analytics_solution" "logicappsmanagement" {
  provider = azurerm.Management
  solution_name         = "LogicAppsManagement"
  location              = azurerm_resource_group.logging.location
  resource_group_name   = azurerm_resource_group.logging.name
  workspace_resource_id = azurerm_log_analytics_workspace.platform.id
  workspace_name        = azurerm_log_analytics_workspace.platform.name

  plan {
    publisher = "Microsoft"
    product   = "OMSGallery/LogicAppsManagement"
  }
}
#SQLDataClassification
resource "azurerm_log_analytics_solution" "updates" {
  provider = azurerm.Management
  solution_name         = "Updates"
  location              = azurerm_resource_group.logging.location
  resource_group_name   = azurerm_resource_group.logging.name
  workspace_resource_id = azurerm_log_analytics_workspace.platform.id
  workspace_name        = azurerm_log_analytics_workspace.platform.name

  plan {
    publisher = "Microsoft"
    product   = "OMSGallery/Updates"
  }
}
