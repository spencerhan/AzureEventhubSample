terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0.2"
    }
  }

  required_version = ">= 1.1.0"
}

provider "azurerm" {
  features {

  }
}
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.resource_group_location
}

resource "azurerm_eventhub_namespace" "eventhub-ns-dev" {
  name                = var.eventhub_namespace_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku                 = var.eventhub_ns_sku
  capacity            = var.eventhub_ns_capacity
}

resource "azurerm_eventhub" "eventhub-dev" {
  name                = var.eventhub_resource_name
  namespace_name      = azurerm_eventhub_namespace.eventhub-ns-dev.name
  resource_group_name = azurerm_resource_group.rg.name
  partition_count     = var.eventhub_partition_count
  message_retention   = var.eventhub_message_retention
}

resource "azurerm_kusto_cluster" "eventhub-cluster-dev" {
  name                = var.kusto_cluster_resource_name
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  sku {
    name     = var.kusto_cluster_sku.name
    capacity = var.kusto_cluster_sku.capacity
  }
}
resource "azurerm_kusto_database" "eventhub-db-dev" {
  name                = var.kusto_database_resource_name
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  cluster_name        = azurerm_kusto_cluster.eventhub-cluster-dev.name
  hot_cache_period    = var.ade_kusto_database_hot_cache_period
  soft_delete_period  = var.ade_kusto_database_soft_delete_period

}



