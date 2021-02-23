data "azurerm_log_analytics_workspace" "platform" {
  provider = azurerm.Management
  name                = "buildingazure-management-logs-001"
  resource_group_name = "management-logging-001"
}

data "azurerm_virtual_network" "identity" {
  provider = azurerm.Identity
  name                = "spoke-identity-westeurope"
  resource_group_name = "identity-spoke-westeurope-001"
}

data "azurerm_subnet" "domaincontrollers" {
  provider = azurerm.Identity
  name                 = "DomainControllers"
  virtual_network_name = data.azurerm_virtual_network.identity.name
  resource_group_name  = "identity-spoke-westeurope-001"
}
resource "azurerm_resource_group" "domaincontrollers" {
  provider = azurerm.Identity
  name     = "identity-domaincontrollers-westeurope-001"
  location = "West Europe"
  tags = {
    "Usage" = "Active Directory Domain Controllers"
  }
}
resource "azurerm_network_interface" "dc04" {
  provider = azurerm.Identity
  name                = "dc04-nic"
  location            = azurerm_resource_group.domaincontrollers.location
  resource_group_name = azurerm_resource_group.domaincontrollers.name
  #This is the on-premises domain controller IP
  dns_servers = ["192.168.1.40"]

  ip_configuration {
    name                          = "internal"
    subnet_id                     = data.azurerm_subnet.domaincontrollers.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_windows_virtual_machine" "dc04" {
  provider = azurerm.Identity
  name                = "dc04"
  resource_group_name = azurerm_resource_group.domaincontrollers.name
  location            = azurerm_resource_group.domaincontrollers.location
  size                = "Standard_B1ms"
  admin_username      = "adminuser"
  admin_password      = "P@$$w0rd1234!"
  license_type = "Windows_Server"
  patch_mode = "AutomaticByOS"
  tags = {
    "Role" = "Domain Controller"
  }
  timezone = "GMT Standard Time"
  zone = 1
  network_interface_ids = [
    azurerm_network_interface.dc04.id,
  ]
  identity {
    type = "SystemAssigned"
  }

  boot_diagnostics {
    storage_account_uri = azurerm_storage_account.bootdiagnostics.primary_blob_endpoint
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter-Core"
    version   = "latest"
  }
}

resource "azurerm_virtual_machine_extension" "dsc" {
  provider = azurerm.Identity
  name                 = "AzureAutomationDSC"
  virtual_machine_id   = azurerm_windows_virtual_machine.dc04.id
  publisher            = "Microsoft.Powershell"
  type                 = "DSC"
  type_handler_version = "2.83"
    settings = <<SETTINGS
  {
            "WmfVersion": "latest",
            "advancedOptions": {
	              "forcePullAndApply": true 
                },
            "Properties": {
                "RegistrationKey": {
                  "UserName": "PLACEHOLDER_DONOTUSE",
                  "Password": "PrivateSettingsRef:registrationKeyPrivate"
                },
                "RegistrationUrl": "https://d1b69341-b68b-4aae-9b98-c13f834bc9b9.agentsvc.we.azure-automation.net/accounts/d1b69341-b68b-4aae-9b98-c13f834bc9b9",
                "NodeConfigurationName": "",
                "ConfigurationMode": "ApplyandAutoCorrect",
                "ConfigurationModeFrequencyMins": 15,
                "RefreshFrequencyMins": 30,
                "RebootNodeIfNeeded": true,
                "ActionAfterReboot": "continueConfiguration",
                "AllowModuleOverwrite": false
                }
  }
  SETTINGS

   protected_settings = <<PROTECTED_SETTINGS
    {
      "Items": {
        "registrationKeyPrivate" : "THagz2BNtqmBE/iCFddIB8vYcDHaMNvAJrJfzJ02wjIHNCrI1Cz1k5EEHptK2j2zbm83aVaTytgY69Y1zFBJgw=="
      }
    }
PROTECTED_SETTINGS
}

resource "azurerm_virtual_machine_extension" "monitor_dependency_agent" {
  provider = azurerm.Identity
  name                  = "DependencyAgent"
  virtual_machine_id  = azurerm_windows_virtual_machine.dc04.id
  publisher             = "Microsoft.Azure.Monitoring.DependencyAgent"
  type                  = "DependencyAgentWindows"
  type_handler_version  = "9.10"
  auto_upgrade_minor_version = true
 
  settings = <<SETTINGS
        {
          "workspaceId": "${data.azurerm_log_analytics_workspace.platform.id}"
        }
SETTINGS
 
  protected_settings = <<PROTECTED_SETTINGS
        {
          "workspaceKey": "HFLW0oC1J8U6egmrDopCyqIorp4RQ6aj8jjtJP976zwJTe9gv2V7qjf890XaYoPhPjNnHhqAuqUSsXbjgUzOow=="
        }
PROTECTED_SETTINGS
}

resource "azurerm_virtual_machine_extension" "network_watcher" {
  provider = azurerm.Identity
  name                  = "NetworkWatcher"
  virtual_machine_id  = azurerm_windows_virtual_machine.dc04.id
  publisher             = "Microsoft.Azure.NetworkWatcher"
  type                  = "NetworkWatcherAgentWindows"
  type_handler_version  = "1.4"
  auto_upgrade_minor_version = true
}

## TODO - DOESNT SEEM TO INSTALL
resource "azurerm_virtual_machine_extension" "microsoft_monitoring_agent" {
  provider = azurerm.Identity
  name                  = "MicrosoftMonitoringAgent"
  virtual_machine_id  = azurerm_windows_virtual_machine.dc04.id
  publisher             = "Microsoft.EnterpriseCloud.Monitoring"
  type                  = "MicrosoftMonitoringAgent"
  type_handler_version  = "1.0"
  auto_upgrade_minor_version = true
}

resource "azurerm_virtual_machine_extension" "azure_monitor_windows_agent" {
  provider = azurerm.Identity
  name                  = "AzureMonitorWindowsAgent"
  virtual_machine_id  = azurerm_windows_virtual_machine.dc04.id
  publisher             = "Microsoft.Azure.Monitor"
  type                  = "AzureMonitorWindowsAgent"
  type_handler_version  = "1.0"
  auto_upgrade_minor_version = true
}

resource "azurerm_virtual_machine_extension" "azure_performance_diagnostic" {
  provider = azurerm.Identity
  name                  = "AzurePerformanceDiagnostics"
  virtual_machine_id  = azurerm_windows_virtual_machine.dc04.id
  publisher             = "Microsoft.Azure.Performance.Diagnostics"
  type                  = "AzurePerformanceDiagnostics"
  type_handler_version  = "1.0"
  auto_upgrade_minor_version = true
}

resource "azurerm_virtual_machine_extension" "azure_policy_guest_configuration" {
  provider = azurerm.Identity
  name                  = "AzurePolicyGuestConfiguration"
  virtual_machine_id  = azurerm_windows_virtual_machine.dc04.id
  publisher             = "Microsoft.GuestConfiguration"
  type                  = "ConfigurationforWindows"
  type_handler_version  = "1.29"
  auto_upgrade_minor_version = true
}

resource "azurerm_virtual_machine_extension" "guest_health_windows_agent" {
  provider = azurerm.Identity
  name                  = "GuestHealthWindowsAgent"
  virtual_machine_id  = azurerm_windows_virtual_machine.dc04.id
  publisher             = "Microsoft.Azure.Monitor.VirtualMachines.GuestHealth"
  type                  = "GuestHealthWindowsAgent"
  type_handler_version  = "1.0"
  auto_upgrade_minor_version = true
}

resource "azurerm_virtual_machine_extension" "microsoft_anti_malware" {
  provider = azurerm.Identity
  name                  = "IaaSAntimalware"
  virtual_machine_id  = azurerm_windows_virtual_machine.dc04.id
  publisher             = "Microsoft.Azure.Security"
  type                  = "IaaSAntimalware"
  type_handler_version  = "1.5"
  auto_upgrade_minor_version = true
}

resource "azurerm_storage_account" "bootdiagnostics" {
  provider = azurerm.Identity
  name                     = "bootdiagnostics12412"
  resource_group_name      = azurerm_resource_group.domaincontrollers.name
  location                 = azurerm_resource_group.domaincontrollers.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    Usage = "Boot Diagnostics"
  }
}
resource "azurerm_monitor_diagnostic_setting" "bootdiagnostics_storageaccount" {
  provider = azurerm.Identity
  name               = "Management-Logs"
  target_resource_id =  azurerm_storage_account.bootdiagnostics.id
  log_analytics_workspace_id = data.azurerm_log_analytics_workspace.platform.id
  
  metric {
    category = "Transaction"

    retention_policy {
      enabled = false
    }
  }
}

resource "azurerm_storage_account" "monitorhostdiagnostics" {
  provider = azurerm.Identity
  name                     = "hostdiagnostics12412"
  resource_group_name      = azurerm_resource_group.domaincontrollers.name
  location                 = azurerm_resource_group.domaincontrollers.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    Usage = "Host Diagnostics"
  }
}
resource "azurerm_monitor_diagnostic_setting" "monitorhostdiagnostics_storageaccount" {
  provider = azurerm.Identity
  name               = "Management-Logs"
  target_resource_id =  azurerm_storage_account.monitorhostdiagnostics.id
  log_analytics_workspace_id = data.azurerm_log_analytics_workspace.platform.id
  
  metric {
    category = "Transaction"

    retention_policy {
      enabled = false
    }
  }
}

