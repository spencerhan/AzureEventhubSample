terraform {
 
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.16.0"
    }
  }
}

provider "azurerm" {
  resource "azurerm_resource_group" "eventhub-dev" {
    name     = var.resource_group_name
    location = var.resource_group_location
  }

  resource "azurerm_eventhub_namespace" "eventhub-dev" {
    name                = var.event_hub_namespace
    location            = var.resource_group_name
    resource_group_name = var.resource_group_location
    sku                 = "Basic"
    capacity            = 5

    tags = {
      environment = var.resource_tag
    }
  }

  resource "azurerm_eventhub" "eventhub-dev" {
    name                = var.resource_name_eventhub
    namespace_name      = var.event_hub_namespace
    resource_group_name = var.resource_group_name
    partition_count     = 8
    message_retention   = 1
    tags = {
      environment = var.resource_tag
    }
  }

  resource "azurerm_kusto_cluster" "eventhub-dev"{
    name = var.resource_name_kusto_cluster
    resource_group_name = var.resource_group_name
    location = var.resource_group_location
    sku = var.ade_kusto_cluster_sku
    tags = {
      environment = var.resource_tag
    }
  }
  resource "azurerm_kusto_database" "eventhub-dev"{
    name = var.resource_name_kusto_database
    resource_group_name = var.resource_group_name
    location = var.resource_group_location
    cluster_name = var.resource_name_kusto_cluster
    hot_cache_period = var.ade_kusto_database_hot_cache_period
    soft_delete_period = var.ade_kusto_database_soft_delete_period
    tags = {
      environment = var.resource_tag
    }
  }
  /* adding eventhub consumer group
    adding eventhub data connection
   */
  resource "azurerm_eventhub_consumer_group" "eventhub-dev"{
    
  }
  resource "azurerm_kusto_eventhub_data_connection" "eventhub-dev"{

  } 
}
