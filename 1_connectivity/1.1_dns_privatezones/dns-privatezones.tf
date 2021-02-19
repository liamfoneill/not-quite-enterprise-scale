resource "azurerm_resource_group" "dnsprivatezones" {
    provider = azurerm.Connectivity
  name     = "connectivity-dnsprivatezones-001"
  location = "West Europe"
  tags = {
    "Usage" = "Azure Private DNS Zones for Private Endpoints"
  }
}
resource "azurerm_private_dns_zone" "azureautomation" {
    provider = azurerm.Connectivity
  name                = "privatelink.azure-automation.net"
  resource_group_name = azurerm_resource_group.dnsprivatezones.name
}

resource "azurerm_private_dns_zone" "sqldatabase" {
    provider = azurerm.Connectivity
  name                = "privatelink.database.windows.net"
  resource_group_name = azurerm_resource_group.dnsprivatezones.name
}

resource "azurerm_private_dns_zone" "blobstorage" {
    provider = azurerm.Connectivity
  name                = "privatelink.blob.core.windows.net"
  resource_group_name = azurerm_resource_group.dnsprivatezones.name
}

resource "azurerm_private_dns_zone" "tablestorage" {
    provider = azurerm.Connectivity
  name                = "privatelink.table.core.windows.net"
  resource_group_name = azurerm_resource_group.dnsprivatezones.name
}

resource "azurerm_private_dns_zone" "queuestorage" {
    provider = azurerm.Connectivity
  name                = "privatelink.queue.core.windows.net"
  resource_group_name = azurerm_resource_group.dnsprivatezones.name
}

resource "azurerm_private_dns_zone" "filestorage" {
    provider = azurerm.Connectivity
  name                = "privatelink.file.core.windows.net"
  resource_group_name = azurerm_resource_group.dnsprivatezones.name
}

resource "azurerm_private_dns_zone" "storageaccount" {
    provider = azurerm.Connectivity
  name                = "privatelink.web.core.windows.net"
  resource_group_name = azurerm_resource_group.dnsprivatezones.name
}

resource "azurerm_private_dns_zone" "datalakegen2storage" {
    provider = azurerm.Connectivity
  name                = "privatelink.dfs.core.windows.net"
  resource_group_name = azurerm_resource_group.dnsprivatezones.name
}

resource "azurerm_private_dns_zone" "cosmosdb_sql" {
    provider = azurerm.Connectivity
  name                = "privatelink.documents.azure.com"
  resource_group_name = azurerm_resource_group.dnsprivatezones.name
}

resource "azurerm_private_dns_zone" "cosmosdb_mongodb" {
    provider = azurerm.Connectivity
  name                = "privatelink.mongo.cosmos.azure.com"
  resource_group_name = azurerm_resource_group.dnsprivatezones.name
}

resource "azurerm_private_dns_zone" "cosmosdb_cassandradb" {
    provider = azurerm.Connectivity
  name                = "privatelink.cassandra.cosmos.azure.com"
  resource_group_name = azurerm_resource_group.dnsprivatezones.name
}

resource "azurerm_private_dns_zone" "cosmosdb_gremlindb" {
    provider = azurerm.Connectivity
  name                = "privatelink.gremlin.cosmos.azure.com"
  resource_group_name = azurerm_resource_group.dnsprivatezones.name
}

resource "azurerm_private_dns_zone" "cosmosdb_table" {
    provider = azurerm.Connectivity
  name                = "privatelink.table.cosmos.azure.com"
  resource_group_name = azurerm_resource_group.dnsprivatezones.name
}

resource "azurerm_private_dns_zone" "postgresql" {
    provider = azurerm.Connectivity
  name                = "privatelink.postgres.database.azure.com"
  resource_group_name = azurerm_resource_group.dnsprivatezones.name
}

resource "azurerm_private_dns_zone" "mysql" {
    provider = azurerm.Connectivity
  name                = "privatelink.mysql.database.azure.com"
  resource_group_name = azurerm_resource_group.dnsprivatezones.name
}

resource "azurerm_private_dns_zone" "mariadb" {
    provider = azurerm.Connectivity
  name                = "privatelink.mariadb.database.azure.com"
  resource_group_name = azurerm_resource_group.dnsprivatezones.name
}

resource "azurerm_private_dns_zone" "keyvault" {
    provider = azurerm.Connectivity
  name                = "privatelink.vaultcore.azure.net"
  resource_group_name = azurerm_resource_group.dnsprivatezones.name
}

resource "azurerm_private_dns_zone" "search" {
    provider = azurerm.Connectivity
  name                = "privatelink.search.windows.net"
  resource_group_name = azurerm_resource_group.dnsprivatezones.name
}

resource "azurerm_private_dns_zone" "container_registry" {
    provider = azurerm.Connectivity
  name                = "privatelink.azurecr.io"
  resource_group_name = azurerm_resource_group.dnsprivatezones.name
}

resource "azurerm_private_dns_zone" "app_configuration" {
    provider = azurerm.Connectivity
  name                = "privatelink.azconfig.io"
  resource_group_name = azurerm_resource_group.dnsprivatezones.name
}
resource "azurerm_private_dns_zone" "servicebus" {
    provider = azurerm.Connectivity
  name                = "privatelink.servicebus.windows.net"
  resource_group_name = azurerm_resource_group.dnsprivatezones.name
}
resource "azurerm_private_dns_zone" "iothub" {
    provider = azurerm.Connectivity
  name                = "privatelink.azure-devices.net"
  resource_group_name = azurerm_resource_group.dnsprivatezones.name
}
resource "azurerm_private_dns_zone" "eventgrid" {
    provider = azurerm.Connectivity
  name                = "privatelink.eventgrid.azure.net"
  resource_group_name = azurerm_resource_group.dnsprivatezones.name
}
resource "azurerm_private_dns_zone" "appservices" {
    provider = azurerm.Connectivity
  name                = "privatelink.azurewebsites.net"
  resource_group_name = azurerm_resource_group.dnsprivatezones.name
}
resource "azurerm_private_dns_zone" "azure_machine_learning" {
    provider = azurerm.Connectivity
  name                = "privatelink.api.azureml.ms"
  resource_group_name = azurerm_resource_group.dnsprivatezones.name
}

resource "azurerm_private_dns_zone" "databricks" {
    provider = azurerm.Connectivity
  name                = "privatelink.notebooks.azure.net"
  resource_group_name = azurerm_resource_group.dnsprivatezones.name
}

resource "azurerm_private_dns_zone" "signalR" {
    provider = azurerm.Connectivity
  name                = "privatelink.service.signalr.net"
  resource_group_name = azurerm_resource_group.dnsprivatezones.name
}

resource "azurerm_private_dns_zone" "cognitiveservices" {
    provider = azurerm.Connectivity
  name                = "privatelink.cognitiveservices.azure.com"
  resource_group_name = azurerm_resource_group.dnsprivatezones.name
}

resource "azurerm_private_dns_zone" "azure_file_sync" {
    provider = azurerm.Connectivity
  name                = "privatelink.afs.azure.net"
  resource_group_name = azurerm_resource_group.dnsprivatezones.name
}
resource "azurerm_private_dns_zone" "datafactory" {
    provider = azurerm.Connectivity
  name                = "privatelink.datafactory.azure.net"
  resource_group_name = azurerm_resource_group.dnsprivatezones.name
}
resource "azurerm_private_dns_zone" "datafactory_portal" {
    provider = azurerm.Connectivity
  name                = "privatelink.azure.com"
  resource_group_name = azurerm_resource_group.dnsprivatezones.name
}
resource "azurerm_private_dns_zone" "redis" {
    provider = azurerm.Connectivity
  name                = "privatelink.redis.cache.windows.net"
  resource_group_name = azurerm_resource_group.dnsprivatezones.name
}
resource "azurerm_private_dns_zone" "monitor_1" {
    provider = azurerm.Connectivity
  name                = "privatelink.monitor.azure.com"
  resource_group_name = azurerm_resource_group.dnsprivatezones.name
}
resource "azurerm_private_dns_zone" "monitor_2" {
    provider = azurerm.Connectivity
  name                = "privatelink.oms.opinsights.azure.com"
  resource_group_name = azurerm_resource_group.dnsprivatezones.name
}
resource "azurerm_private_dns_zone" "monitor_3" {
    provider = azurerm.Connectivity
  name                = "privatelink.ods.opinsights.azure.com"
  resource_group_name = azurerm_resource_group.dnsprivatezones.name
}
resource "azurerm_private_dns_zone" "monitor_4" {
    provider = azurerm.Connectivity
  name                = "privatelink.agentsvc.azure-automation.net"
  resource_group_name = azurerm_resource_group.dnsprivatezones.name
}

resource "azurerm_private_dns_zone" "azurebackup_westeurope" {
    provider = azurerm.Connectivity
  name                = "privatelink.westeurope.backup.windowsazure.com"
  resource_group_name = azurerm_resource_group.dnsprivatezones.name
}

resource "azurerm_private_dns_zone" "azurebackup_northeurope" {
    provider = azurerm.Connectivity
  name                = "privatelink.northeurope.backup.windowsazure.com"
  resource_group_name = azurerm_resource_group.dnsprivatezones.name
}

resource "azurerm_private_dns_zone" "aks_westeurope" {
    provider = azurerm.Connectivity
  name                = "privatelink.westeurope.azmk8s.io"
  resource_group_name = azurerm_resource_group.dnsprivatezones.name
}

resource "azurerm_private_dns_zone" "aks_northeurope" {
    provider = azurerm.Connectivity
  name                = "privatelink.northeurope.azmk8s.io"
  resource_group_name = azurerm_resource_group.dnsprivatezones.name
}