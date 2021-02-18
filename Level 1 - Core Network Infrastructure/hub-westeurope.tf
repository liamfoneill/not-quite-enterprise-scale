resource "azurerm_resource_group" "hubwesteurope" {
  name     = "connectivity-hub-westeurope-001"
  location = "West Europe"
  tags = {
    "Usage" = "Networking Hub/VPN"
  }
}

resource "azurerm_virtual_network" "hubwesteurope" {
  name                = "hub-westeurope"
  location            = azurerm_resource_group.hubwesteurope.location
  resource_group_name = azurerm_resource_group.hubwesteurope.name
  address_space       = ["10.0.0.0/22"]
  depends_on = [ azurerm_network_watcher.westeurope ]
}

resource "azurerm_subnet" "hubwesteuropegateway" {
  name                 = "GatewaySubnet"
  resource_group_name  = azurerm_resource_group.hubwesteurope.name
  virtual_network_name = azurerm_virtual_network.hubwesteurope.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_public_ip" "hubwesteuropegateway" {
  name                = "Gateway-PIP"
  location            = azurerm_resource_group.hubwesteurope.location
  resource_group_name = azurerm_resource_group.hubwesteurope.name

  allocation_method = "Dynamic"
}

resource "azurerm_virtual_network_gateway" "hubwesteuropegateway" {
  name                = "hubwesteuropegateway"
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

resource "azurerm_local_network_gateway" "nightingaleway" {
  name                = "Nightingale-Way"
  resource_group_name = azurerm_resource_group.hubwesteurope.name
  location            = azurerm_resource_group.hubwesteurope.location
  gateway_fqdn        = "59nightingale.redirectme.net"
  address_space       = ["192.168.0.0/22"]
}

resource "azurerm_virtual_network_gateway_connection" "nightingaleway" {
  name                = "nightingaleway"
  location            = azurerm_resource_group.hubwesteurope.location
  resource_group_name = azurerm_resource_group.hubwesteurope.name

  type                       = "IPsec"
  virtual_network_gateway_id = azurerm_virtual_network_gateway.hubwesteuropegateway.id
  local_network_gateway_id   = azurerm_local_network_gateway.nightingaleway.id

  shared_key = "WalkingDead!"
}