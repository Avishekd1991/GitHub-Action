data "azurerm_public_ip" "Datablock2" {
name = "LB-Public-IP"
resource_group_name = "Avishek_LB_RG"
}

resource "azurerm_lb" "lb" {
  name                = "rajuLB"
  location            = "centralus"
  resource_group_name = "Avishek_LB_RG"

  frontend_ip_configuration {
    name                 ="LB-PublicIPAddress"
    public_ip_address_id = data.azurerm_public_ip.Datablock2.id
  }
}

resource "azurerm_lb_backend_address_pool" "example" {
  loadbalancer_id = azurerm_lb.lb.id
  name            = "BackEndAddressPool"
}

resource "azurerm_lb_probe" "example2" {
  loadbalancer_id = azurerm_lb.lb.id
  name            = "nginx-server"
  port            = 80
}

resource "azurerm_lb_rule" "example3" {
  loadbalancer_id                = azurerm_lb.lb.id
  name                           = "azurerm-LBRule"
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  frontend_ip_configuration_name = "LB-PublicIPAddress"
}