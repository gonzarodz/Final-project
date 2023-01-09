output "subnet_id_test" {
  value = "${azurerm_subnet.test.id}"
}
output "network_interface_id" {
  value = "${azurerm_network_interface.internal.id}"
}

