resource "azurerm_resource_group" "logging" {
  name     = "platform-logging-001"
  location = "West Europe"
  tags = {
    "Usage" = "Log Analytics"
  }
}

# Log Analytics Workspace
resource "azurerm_log_analytics_workspace" "platform" {
  name                = "buildingazure-platform-logs-001"
  location            = azurerm_resource_group.logging.location
  resource_group_name = azurerm_resource_group.logging.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
  daily_quota_gb = 1
  internet_ingestion_enabled = true
  internet_query_enabled = true
}

# Link Between Automation Account and Log Analytics
resource "azurerm_log_analytics_linked_service" "platform" {
  resource_group_name = azurerm_resource_group.logging.name
  workspace_id        = azurerm_log_analytics_workspace.platform.id
  read_access_id      = azurerm_automation_account.platform.id
}
# Log Analytics Solutions
#Container Insights
resource "azurerm_log_analytics_solution" "containerinsights" {
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
