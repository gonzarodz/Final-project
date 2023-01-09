resource "azurerm_virtual_network" "test" {
  name                 = "${var.application_type}-${var.resource_type}"
  address_space        = "${var.address_space}"
  location             = "${var.location}"
  resource_group_name  = "${var.resource_group}"
}
resource "azurerm_subnet" "test" {
  name                 = "${var.application_type}-${var.resource_type}-sub"
  resource_group_name  = "${var.resource_group}"
  virtual_network_name = "${azurerm_virtual_network.test.name}"
  address_prefixes      = "${var.address_prefix_test}"
}
resource "azurerm_network_interface" "internal" {
  name                = "${var.application_type}-nic"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group}"

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.test.id
    private_ip_address_allocation = "Dynamic"
  }
}

data "azurerm_shared_image" "example" {
  name                = "ubuntu"
  gallery_name        = "Linux"
  resource_group_name = "final-project"
}

resource "azurerm_linux_virtual_machine" "example" {
  name                = "${var.application_type}-vm"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group}"
  size                = "Standard_DS2_v2"
  admin_username      = "azureuser"
  network_interface_ids = [azurerm_network_interface.internal.id,]
  admin_ssh_key {
    username   = "azureuser"
    public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCxtTVFTXfUH/M13szPxa9sKqlO+GvxX15o08B88g3nvHq+S7l9MwUinN/NXthgFPEIci3v0Js8kWuveHAG+ANWIluW8tazAEK/aBwTpMCa1a6N7UEFE9iFmfVtQbAYWT425Hl552ozFKqcv6UZvZv11I7rYnMHA/DaPEuhuNo7wyY+dOAyrh0ypmxg/+22KmOJ2UmbT1Z9Dt8+XJfnIY90F979SO+0xYOvYx6aLuu+YghliOECHcG+W9hXrm7qYLCxdO/yNXgiN6yD/CmrfzoPpgIuQ1wm0PgtGYUu2db89ofJA7ZezyLXqcbJ59q7uGn0PgjDILhvasjqhh/Lu0dR/NeR/qwKbXs2dwQ5S6qTw3x+y8kZ+uXDJ7JO7vY1y0433IBkA661KwebmQowJSlvKJtDFwcO+dUvRc9Hxi6sb0jHAUHyh4cT+93qwsSIQgbOdpBvimqYL8IVHHU8IsocMDRr9ZyIeMlOa4JZoUYMzsD+F2kPpXnBFsK8WkbtuQ0="
  }
  os_disk {
    caching           = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_id     = data.azurerm_shared_image.example.id
}
