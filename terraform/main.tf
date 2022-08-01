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
    name     = "${var.resource_group_name}"
    location = "${var.resource_group_location}"
  }

  resource "azurerm_eventhub_namespace" "eventhub-dev" {
    name                = "${var.event_hub_namespace}"
    location            = "${var.resource_group_name}"
    resource_group_name = "${var.resource_group_location}"
    sku                 = "Basic"
    capacity            = 5

    tags = {
      environment = "${resource_tag}"
    }
  }

  resource "azurerm_eventhub" "eventhub-dev" {
    name                = "${var.resource_name_eventhub}"
    namespace_name      = "${var.event_hub_namespace}"
    resource_group_name = "${var.resource_group_name}"
    partition_count     = 8
    message_retention   = 1
    tags = {
      environment = "${resource_tag}"
    }
  }

  resource "azurerm_kusto_cluster" "eventhub-dev"{
    name = "${}"
    resource_group_name = "${resource_group_name}"
    location = "${resource_group_location}"
    tags = {
      environment = "${resource_tag}"
    }
  }
  
}
