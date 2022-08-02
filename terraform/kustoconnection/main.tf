resource "azurerm_kusto_eventhub_data_connection" "eventhub-dbcon-dev" {
  name                = var.eventhub_connection_name
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  cluster_name        = azurerm_kusto_cluster.eventhub-cluster-dev.name
  database_name       = azurerm_kusto_database.eventhub-db-dev.name
  eventhub_id         = azurerm_eventhub.eventhub-dev.id
  consumer_group      = azurerm_eventhub_consumer_group.eventhub-cg-dev.name

  /* optional */
  table_name = var.eventhub_connection_data_table_name
  mapping_rule_name = var.eventhub_connection_data_mapping_rule
  data_format = var.eventhub_connection_data_format
}