#aks deployment
#docker file--dockar image
#deployment.yaml
#cluser--collect nodes--create using terraform

terraform {
  required_providers {
    azurerm = {
      version = "~>4.0"
      source  = "hashicorp/azurerm"

    }
  }
}
provider "azurerm" {
  features {}
  #serviceprincple-appid,client secretID and tenantid--AAD/RBAC
  subscription_id = "f0f8949f-5fa9-4f81-9246-d76de23f445f"
  tenant_id = "40e76d85-ad85-407a-89f7-0e9eb8ea3462"
}

resource "azurerm_resource_group" "aks_rg" {
  name     = "RGtest"
  location = "East US"
}

resource "azurerm_kubernetes_cluster" "my_aks" {
  name                = "subba-akscluster"
  resource_group_name = azurerm_resource_group.aks_rg.name
  location            = azurerm_resource_group.aks_rg.location
  dns_prefix          = "myakscluster"

  default_node_pool {
    name       = "default"
    node_count = 2
    vm_size    = "Standard_DS2_v2"
  }

  identity {
    type = "SystemAssigned"
  }
}
