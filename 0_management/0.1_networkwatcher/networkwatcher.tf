## CONNECTIVITY
resource "azurerm_resource_group" "connectivity_networkwatcher" {
  provider = azurerm.Connectivity
  name     = "connectivity-networkwatcher-001"
  location = "West Europe"
  tags = {
    "Usage" = "Network Watcher"
  }
}

resource "azurerm_network_watcher" "connectivity_westeurope" {
  provider = azurerm.Connectivity
  name                = "westeurope"
  location            = "westeurope"
  resource_group_name = azurerm_resource_group.connectivity_networkwatcher.name
}

resource "azurerm_network_watcher" "connectivity_northeurope" {
  provider = azurerm.Connectivity
  name                = "northeurope"
  location            = "northeurope"
  resource_group_name = azurerm_resource_group.connectivity_networkwatcher.name
}

##IDENTITY
resource "azurerm_resource_group" "identity_networkwatcher" {
  provider = azurerm.Identity
  name     = "identity-networkwatcher-001"
  location = "West Europe"
  tags = {
    "Usage" = "Network Watcher"
  }
}

resource "azurerm_network_watcher" "identity_westeurope" {
  provider = azurerm.Identity
  name                = "westeurope"
  location            = "westeurope"
  resource_group_name = azurerm_resource_group.identity_networkwatcher.name
}

resource "azurerm_network_watcher" "identity_northeurope" {
  provider = azurerm.Identity
  name                = "northeurope"
  location            = "northeurope"
  resource_group_name = azurerm_resource_group.identity_networkwatcher.name
}

##MANAGEMENT
resource "azurerm_resource_group" "management_networkwatcher" {
  provider = azurerm.Management
  name     = "management-networkwatcher-001"
  location = "West Europe"
  tags = {
    "Usage" = "Network Watcher"
  }
}

resource "azurerm_network_watcher" "management_westeurope" {
  provider = azurerm.Management
  name                = "westeurope"
  location            = "westeurope"
  resource_group_name = azurerm_resource_group.management_networkwatcher.name
}

resource "azurerm_network_watcher" "management_northeurope" {
  provider = azurerm.Management
  name                = "northeurope"
  location            = "northeurope"
  resource_group_name = azurerm_resource_group.management_networkwatcher.name
}

##CORPORATE
resource "azurerm_resource_group" "corporate_networkwatcher" {
  provider = azurerm.Corporate
  name     = "corporate-networkwatcher-001"
  location = "West Europe"
  tags = {
    "Usage" = "Network Watcher"
  }
}

resource "azurerm_network_watcher" "corporate_westeurope" {
  provider = azurerm.Corporate
  name                = "westeurope"
  location            = "westeurope"
  resource_group_name = azurerm_resource_group.corporate_networkwatcher.name
}

resource "azurerm_network_watcher" "corporate_northeurope" {
  provider = azurerm.Corporate
  name                = "northeurope"
  location            = "northeurope"
  resource_group_name = azurerm_resource_group.corporate_networkwatcher.name
}

##ONLINE
resource "azurerm_resource_group" "online_networkwatcher" {
  provider = azurerm.Online
  name     = "online-networkwatcher-001"
  location = "West Europe"
  tags = {
    "Usage" = "Network Watcher"
  }
}

resource "azurerm_network_watcher" "online_westeurope" {
  provider = azurerm.Online
  name                = "westeurope"
  location            = "westeurope"
  resource_group_name = azurerm_resource_group.online_networkwatcher.name
}

resource "azurerm_network_watcher" "online_northeurope" {
  provider = azurerm.Online
  name                = "northeurope"
  location            = "northeurope"
  resource_group_name = azurerm_resource_group.online_networkwatcher.name
}

##MANUFACTURING
resource "azurerm_resource_group" "manufacturing_networkwatcher" {
  provider = azurerm.Manufacturing
  name     = "manufacturing-networkwatcher-001"
  location = "West Europe"
  tags = {
    "Usage" = "Network Watcher"
  }
}

resource "azurerm_network_watcher" "manufacuring_westeurope" {
  provider = azurerm.Manufacturing
  name                = "westeurope"
  location            = "westeurope"
  resource_group_name = azurerm_resource_group.manufacturing_networkwatcher.name
}

resource "azurerm_network_watcher" "manufacuring_northeurope" {
  provider = azurerm.Manufacturing
  name                = "northeurope"
  location            = "northeurope"
  resource_group_name = azurerm_resource_group.manufacturing_networkwatcher.name
}

##SANDBOX
resource "azurerm_resource_group" "sandbox_networkwatcher" {
  provider = azurerm.Sandbox
  name     = "sandbox-networkwatcher-001"
  location = "West Europe"
  tags = {
    "Usage" = "Network Watcher"
  }
}

resource "azurerm_network_watcher" "sandbox_westeurope" {
  provider = azurerm.Sandbox
  name                = "westeurope"
  location            = "westeurope"
  resource_group_name = azurerm_resource_group.sandbox_networkwatcher.name
}

resource "azurerm_network_watcher" "sandbox_northeurope" {
  provider = azurerm.Sandbox
  name                = "northeurope"
  location            = "northeurope"
  resource_group_name = azurerm_resource_group.sandbox_networkwatcher.name
}

