resource "azurerm_resource_group" "identitywesteurope" {
  provider = azurerm.Identity
  name     = "identity-spoke-westeurope-001"
  location = "West Europe"
  tags = {
    "Usage" = "Active Directory Domain Controllers"
  }
}

resource "azurerm_virtual_network" "identity" {
  provider = azurerm.Identity
  name                = "spoke-identity-westeurope"
  location            = azurerm_resource_group.identitywesteurope.location
  resource_group_name = azurerm_resource_group.identitywesteurope.name
  address_space       = ["10.0.4.0/22"]
}

resource "azurerm_subnet" "domaincontrollers" {
  provider = azurerm.Identity
  name                 = "DomainControllers"
  resource_group_name  = azurerm_resource_group.identitywesteurope.name
  virtual_network_name = azurerm_virtual_network.identity.name
  address_prefixes     = ["10.0.4.0/24"]
}

resource "azurerm_network_security_group" "domaincontroller_nsg" {
  provider = azurerm.Identity
  name                = "DomainController-NSG"
  location            = azurerm_resource_group.identitywesteurope.location
  resource_group_name = azurerm_resource_group.identitywesteurope.name
}

resource "azurerm_monitor_diagnostic_setting" "domaincontroller_nsg" {
  provider = azurerm.Connectivity
  name               = "Platform-Logs"
  target_resource_id = azurerm_network_security_group.domaincontroller_nsg.id
  log_analytics_workspace_id = data.azurerm_log_analytics_workspace.platform.id

  log {
    category = "NetworkSecurityGroupEvent"
    enabled  = true

    retention_policy {
      enabled = false
    }
  }
    log {
    category = "NetworkSecurityGroupRuleCounter"
    enabled  = true

    retention_policy {
      enabled = false
    }
  }
}

# DATE: Network Watcher West Europe (need to be in same subscription as NSG)
data "azurerm_network_watcher" "identity_westeurope" {
  provider = azurerm.Identity
  name                = "westeurope"
  resource_group_name = "identity-networkwatcher-001"
}
# DATA: NSG Flow Log Storage Account
data "azurerm_storage_account" "nsgflowlogs_westeurope" {
  provider = azurerm.Management
  name                     = "bansgflowlogswe"
  resource_group_name      = "management-nsgflowlogs-westeurope-001"
}
# DATA: Log Analytics workspace
data "azurerm_log_analytics_workspace" "platform" {
  provider = azurerm.Management
  name                = "buildingazure-management-logs-001"
  resource_group_name = "management-logging-001"
}

resource "azurerm_network_watcher_flow_log" "domaincontroller_nsg" {
  provider = azurerm.Identity
  network_watcher_name = data.azurerm_network_watcher.identity_westeurope.name
  resource_group_name  = "identity-networkwatcher-001"

  network_security_group_id = azurerm_network_security_group.domaincontroller_nsg.id
  storage_account_id        = data.azurerm_storage_account.nsgflowlogs_westeurope.id
  enabled                   = true

  retention_policy {
    enabled = true
    days    = 7
  }

  traffic_analytics {
    enabled               = true
    workspace_id          = data.azurerm_log_analytics_workspace.platform.workspace_id
    workspace_region      = data.azurerm_log_analytics_workspace.platform.location
    workspace_resource_id = data.azurerm_log_analytics_workspace.platform.id
    interval_in_minutes   = 10
  }
}

resource "azurerm_virtual_network_peering" "spoke_to_hub" {
  provider = azurerm.Identity
  name                      = "Hub"
  resource_group_name       = azurerm_resource_group.identitywesteurope.name
  virtual_network_name      = azurerm_virtual_network.identity.name
  remote_virtual_network_id = data.azurerm_virtual_network.hub_westeurope.id
  allow_virtual_network_access = true
  allow_forwarded_traffic = true
  use_remote_gateways = true
  allow_gateway_transit = true
}

# WEST EUROPE HUB VNET
data "azurerm_virtual_network" "hub_westeurope" {
  provider = azurerm.Connectivity
  name                = "hub-westeurope"
  resource_group_name = "connectivity-hub-westeurope-001"
}

resource "azurerm_virtual_network_peering" "hub_to_spoke" {
  provider = azurerm.Connectivity
  name                      = "Identity"
  resource_group_name       = "connectivity-hub-westeurope-001"
  virtual_network_name      = "hub-westeurope"
  remote_virtual_network_id = azurerm_virtual_network.identity.id
  allow_virtual_network_access = true
  allow_forwarded_traffic = true
  allow_gateway_transit = true
}