resource "azurerm_network_interface" "main" {
  name                = "nic-project3"
  location            = var.location
  resource_group_name = var.resource_group

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = var.public_ip_address_id
  }
}

resource "azurerm_linux_virtual_machine" "main" {
  name                = "${var.application_type}-${var.resource_type}"
  location            = var.location
  resource_group_name = var.resource_group
  size                = "Standard_DS2_v2"
  admin_username      = "adminuser"
  network_interface_ids = [azurerm_network_interface.main.id]
  admin_ssh_key {
    username   = "adminuser"
    public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDXqGGDowdt5HBv8ERNr+WK+ZU9RQobka91VCSSO0C2gzjj9b8lOUSVkpTS9VhUkVoxygduO7/htF6nDNfieApb++1OrAdRwvv257XKwA/vIvLG2ZHTrFZlkSgvtebyod39Dpv5A++5EzlyJlLf8i/INsx4M9sa/LElEeicZpMLQ8CYy7MF6E0YASorN571A2SLd1xC2Tf2CwPF9jVB8hRw1nNt4LZBV4xcYqHzSpGeABvC2RIH1yimJUmq768K0RLbpiiiyIN5FSL3lNTyABzK+VCovo+TPcHFAWDI6CJg8txlPHIWFfeEpYckt/euQRdXARDIoNX5CqWimXVc/DHt7xKzTSFM+g4qinisU5p7qbzsmWTPpmFdZN8eTVOu4Sco1AO88qvag0+9n4nTVw+D9pf/lg6qxDbixyCAD5XqO0HqVgFKUOUJaPZYqzC9kjAMpGzn0QagldRZGnK77rjpetH6xTIfUDVJWvsWfrt2AgtaqVtXXRV2YIt5yak45XE= insim\\dm46ue@LPZWJP000002938"
  }
  os_disk {
    caching           = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
}
