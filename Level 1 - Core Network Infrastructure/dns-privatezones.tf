resource "azurerm_resource_group" "dnsprivatezones" {
  name     = "connectivity-dnsprivatezones-001"
  location = "West Europe"
  tags = {
    "Usage" = "Azure Private DNS Zones for Private Endpoints"
  }
}
resource "azurerm_private_dns_zone" "azureautomation" {
  name                = "privatelink.azure-automation.net"
  resource_group_name = azurerm_resource_group.dnsprivatezones.name
}

resource "azurerm_private_dns_zone" "sqldatabase" {
  name                = "privatelink.database.windows.net"
  resource_group_name = azurerm_resource_group.dnsprivatezones.name
}

resource "azurerm_private_dns_zone" "blobstorage" {
  name                = "privatelink.blob.core.windows.net"
  resource_group_name = azurerm_resource_group.dnsprivatezones.name
}

resource "azurerm_private_dns_zone" "tablestorage" {
  name                = "privatelink.table.core.windows.net"
  resource_group_name = azurerm_resource_group.dnsprivatezones.name
}

resource "azurerm_private_dns_zone" "queuestorage" {
  name                = "privatelink.queue.core.windows.net"
  resource_group_name = azurerm_resource_group.dnsprivatezones.name
}

resource "azurerm_private_dns_zone" "filestorage" {
  name                = "privatelink.file.core.windows.net"
  resource_group_name = azurerm_resource_group.dnsprivatezones.name
}

resource "azurerm_private_dns_zone" "storageaccount" {
  name                = "privatelink.web.core.windows.net"
  resource_group_name = azurerm_resource_group.dnsprivatezones.name
}

resource "azurerm_private_dns_zone" "datalakegen2storage" {
  name                = "privatelink.dfs.core.windows.net"
  resource_group_name = azurerm_resource_group.dnsprivatezones.name
}

resource "azurerm_private_dns_zone" "cosmosdb_sql" {
  name                = "privatelink.documents.azure.com"
  resource_group_name = azurerm_resource_group.dnsprivatezones.name
}

resource "azurerm_private_dns_zone" "cosmosdb_mongodb" {
  name                = "privatelink.mongo.cosmos.azure.com"
  resource_group_name = azurerm_resource_group.dnsprivatezones.name
}

resource "azurerm_private_dns_zone" "cosmosdb_cassandradb" {
  name                = "privatelink.cassandra.cosmos.azure.com"
  resource_group_name = azurerm_resource_group.dnsprivatezones.name
}

resource "azurerm_private_dns_zone" "cosmosdb_gremlindb" {
  name                = "privatelink.gremlin.cosmos.azure.com"
  resource_group_name = azurerm_resource_group.dnsprivatezones.name
}

resource "azurerm_private_dns_zone" "cosmosdb_table" {
  name                = "privatelink.table.cosmos.azure.com"
  resource_group_name = azurerm_resource_group.dnsprivatezones.name
}

resource "azurerm_private_dns_zone" "postgresql" {
  name                = "privatelink.postgres.database.azure.com"
  resource_group_name = azurerm_resource_group.dnsprivatezones.name
}

resource "azurerm_private_dns_zone" "mysql" {
  name                = "privatelink.mysql.database.azure.com"
  resource_group_name = azurerm_resource_group.dnsprivatezones.name
}

resource "azurerm_private_dns_zone" "mariadb" {
  name                = "privatelink.mariadb.database.azure.com"
  resource_group_name = azurerm_resource_group.dnsprivatezones.name
}

resource "azurerm_private_dns_zone" "keyvault" {
  name                = "privatelink.vaultcore.azure.net"
  resource_group_name = azurerm_resource_group.dnsprivatezones.name
}

resource "azurerm_private_dns_zone" "search" {
  name                = "privatelink.search.windows.net"
  resource_group_name = azurerm_resource_group.dnsprivatezones.name
}

resource "azurerm_private_dns_zone" "container_registry" {
  name                = "privatelink.azurecr.io"
  resource_group_name = azurerm_resource_group.dnsprivatezones.name
}

resource "azurerm_private_dns_zone" "app_configuration" {
  name                = "privatelink.azconfig.io"
  resource_group_name = azurerm_resource_group.dnsprivatezones.name
}
resource "azurerm_private_dns_zone" "servicebus" {
  name                = "privatelink.servicebus.windows.net"
  resource_group_name = azurerm_resource_group.dnsprivatezones.name
}
resource "azurerm_private_dns_zone" "iothub" {
  name                = "privatelink.azure-devices.net"
  resource_group_name = azurerm_resource_group.dnsprivatezones.name
}
resource "azurerm_private_dns_zone" "eventgrid" {
  name                = "privatelink.eventgrid.azure.net"
  resource_group_name = azurerm_resource_group.dnsprivatezones.name
}
resource "azurerm_private_dns_zone" "appservices" {
  name                = "privatelink.azurewebsites.net"
  resource_group_name = azurerm_resource_group.dnsprivatezones.name
}
resource "azurerm_private_dns_zone" "azure_machine_learning" {
  name                = "privatelink.api.azureml.ms"
  resource_group_name = azurerm_resource_group.dnsprivatezones.name
}

resource "azurerm_private_dns_zone" "databricks" {
  name                = "privatelink.notebooks.azure.net"
  resource_group_name = azurerm_resource_group.dnsprivatezones.name
}

resource "azurerm_private_dns_zone" "signalR" {
  name                = "privatelink.service.signalr.net"
  resource_group_name = azurerm_resource_group.dnsprivatezones.name
}

resource "azurerm_private_dns_zone" "cognitiveservices" {
  name                = "privatelink.cognitiveservices.azure.com"
  resource_group_name = azurerm_resource_group.dnsprivatezones.name
}

resource "azurerm_private_dns_zone" "azure_file_sync" {
  name                = "privatelink.afs.azure.net"
  resource_group_name = azurerm_resource_group.dnsprivatezones.name
}
resource "azurerm_private_dns_zone" "datafactory" {
  name                = "privatelink.datafactory.azure.net"
  resource_group_name = azurerm_resource_group.dnsprivatezones.name
}
resource "azurerm_private_dns_zone" "datafactory_portal" {
  name                = "privatelink.azure.com"
  resource_group_name = azurerm_resource_group.dnsprivatezones.name
}
resource "azurerm_private_dns_zone" "redis" {
  name                = "privatelink.redis.cache.windows.net"
  resource_group_name = azurerm_resource_group.dnsprivatezones.name
}
resource "azurerm_private_dns_zone" "monitor_1" {
  name                = "privatelink.monitor.azure.com"
  resource_group_name = azurerm_resource_group.dnsprivatezones.name
}
resource "azurerm_private_dns_zone" "monitor_2" {
  name                = "privatelink.oms.opinsights.azure.com"
  resource_group_name = azurerm_resource_group.dnsprivatezones.name
}
resource "azurerm_private_dns_zone" "monitor_3" {
  name                = "privatelink.ods.opinsights.azure.com"
  resource_group_name = azurerm_resource_group.dnsprivatezones.name
}
resource "azurerm_private_dns_zone" "monitor_4" {
  name                = "privatelink.agentsvc.azure-automation.net"
  resource_group_name = azurerm_resource_group.dnsprivatezones.name
}

resource "azurerm_private_dns_zone" "azurebackup_westeurope" {
  name                = "privatelink.westeurope.backup.windowsazure.com"
  resource_group_name = azurerm_resource_group.dnsprivatezones.name
}

resource "azurerm_private_dns_zone" "azurebackup_northeurope" {
  name                = "privatelink.northeurope.backup.windowsazure.com"
  resource_group_name = azurerm_resource_group.dnsprivatezones.name
}

resource "azurerm_private_dns_zone" "aks_westeurope" {
  name                = "privatelink.westeurope.azmk8s.io"
  resource_group_name = azurerm_resource_group.dnsprivatezones.name
}

resource "azurerm_private_dns_zone" "aks_northeurope" {
  name                = "privatelink.northeurope.azmk8s.io"
  resource_group_name = azurerm_resource_group.dnsprivatezones.name
}