data "azurerm_log_analytics_workspace" "platform" {
  provider = azurerm.Management
  name                = "buildingazure-management-logs-001"
  resource_group_name = "management-logging-001"
}


resource "azurerm_resource_group" "hubwesteurope" {
  provider = azurerm.Connectivity
  name     = "connectivity-hub-westeurope-001"
  location = "West Europe"
  tags = {
    "Usage" = "Networking Hub/VPN"
  }
}

resource "azurerm_virtual_network" "hubwesteurope" {
  provider = azurerm.Connectivity
  name                = "hub-westeurope"
  location            = azurerm_resource_group.hubwesteurope.location
  resource_group_name = azurerm_resource_group.hubwesteurope.name
  address_space       = ["10.0.0.0/22"]
}

resource "azurerm_subnet" "hubwesteuropegateway" {
  provider = azurerm.Connectivity
  name                 = "GatewaySubnet"
  resource_group_name  = azurerm_resource_group.hubwesteurope.name
  virtual_network_name = azurerm_virtual_network.hubwesteurope.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_public_ip" "hubwesteuropegateway" {
  provider = azurerm.Connectivity
  name                = "hub-westeurope-gateway-pip"
  location            = azurerm_resource_group.hubwesteurope.location
  resource_group_name = azurerm_resource_group.hubwesteurope.name

  allocation_method = "Dynamic"
}

resource "azurerm_monitor_diagnostic_setting" "hub_westeurope_gateway_pip" {
  provider = azurerm.Connectivity
  name               = "Platform-Logs"
  target_resource_id = azurerm_public_ip.hubwesteuropegateway.id
  log_analytics_workspace_id = data.azurerm_log_analytics_workspace.platform.id

  log {
    category = "DDoSProtectionNotifications"
    enabled  = true

    retention_policy {
      enabled = false
    }
  }
    log {
    category = "DDoSMitigationFlowLogs"
    enabled  = true

    retention_policy {
      enabled = false
    }
  }

    log {
    category = "DDoSMitigationReports"
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

resource "azurerm_virtual_network_gateway" "hubwesteuropegateway" {
  provider = azurerm.Connectivity
  name                = "hub-westeurope-gateway"
  location            = azurerm_resource_group.hubwesteurope.location
  resource_group_name = azurerm_resource_group.hubwesteurope.name

  type     = "Vpn"
  vpn_type = "RouteBased"

  active_active = false
  enable_bgp    = false
  sku           = "Basic"

  ip_configuration {
    name                          = "vnetGatewayConfig"
    public_ip_address_id          = azurerm_public_ip.hubwesteuropegateway.id
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = azurerm_subnet.hubwesteuropegateway.id
  }  
}

resource "azurerm_monitor_diagnostic_setting" "hub_westeurope_gateway" {
  provider = azurerm.Connectivity
  name               = "Platform-Logs"
  target_resource_id = azurerm_virtual_network_gateway.hubwesteuropegateway.id
  log_analytics_workspace_id = data.azurerm_log_analytics_workspace.platform.id

  log {
    category = "GatewayDiagnosticLog"
    enabled  = true

    retention_policy {
      enabled = false
    }
  }
    log {
    category = "TunnelDiagnosticLog"
    enabled  = true

    retention_policy {
      enabled = false
    }
  }

    log {
    category = "RouteDiagnosticLog"
    enabled  = true

    retention_policy {
      enabled = false
    }
  }

   log {
    category = "IKEDiagnosticLog"
    enabled  = true

    retention_policy {
      enabled = false
    }
  }

  log {
    category = "P2SDiagnosticLog"
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

resource "azurerm_local_network_gateway" "nightingaleway" {
  provider = azurerm.Connectivity
  name                = "nightingale-way"
  resource_group_name = azurerm_resource_group.hubwesteurope.name
  location            = azurerm_resource_group.hubwesteurope.location
  gateway_fqdn        = "59nightingale.redirectme.net"
  address_space       = ["192.168.0.0/22"]
}

resource "azurerm_virtual_network_gateway_connection" "nightingaleway" {
  provider = azurerm.Connectivity
  name                = "nightingale-way"
  location            = azurerm_resource_group.hubwesteurope.location
  resource_group_name = azurerm_resource_group.hubwesteurope.name

  type                       = "IPsec"
  virtual_network_gateway_id = azurerm_virtual_network_gateway.hubwesteuropegateway.id
  local_network_gateway_id   = azurerm_local_network_gateway.nightingaleway.id

  shared_key = "WalkingDead!"
}