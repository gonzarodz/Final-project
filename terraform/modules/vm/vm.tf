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
  admin_username      = "admin"
  network_interface_ids = ["idk",]
  admin_ssh_key {
    username   = "adminuser"
    public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQClCBen7K5xEU22OEGvFuuKf9h45Q8iKZWvCLALpaGEmZ06mCZOagyzkiNy7IYv/yfde499pAEMVFu/NOU/2jdm7KI6HxIOT8Qy+t2K5XtrZBoTK8Dg1PGcfdtAuO4VL1tmul8CPBHt1bTyMsj2+2grQ8OETwHX++bo5FGNTN9locLmxJ89bdnsvhXZCyf5liCUE42RHrO4dDdMSQ4HdQKwa29ClsyfSIbAzUCR01KQPuNeSQ1O6urTY9E4yzU6KS28jgPnlYTnDrieBLbDnTstr844oA8GrkBU6N9YWzMrxA7HFsSmVay5Uyqmab7QJ1cdT4KbDNkKhfhtDElav8WQy6Oh5gGRWRzZaDR7XLzcg1KE7oAGjker8S5cJ5NWSAoQYAy7luh0ulPCaB+7hUl+y+FEjjB3jg6G28BJNgbfAqJk1Yv0MrSnBrIJ49QNHUScg25/LJl25aiNdUaBJdP2SvyJlVyK+5AgjyZHTVpVMdGFQaOW/QOieRhXVKXMejM="
  }
  os_disk {
    caching           = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_id     = data.azurerm_shared_image.example.id
}
