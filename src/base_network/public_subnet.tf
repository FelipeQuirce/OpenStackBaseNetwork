resource "openstack_networking_network_v2" "network" {
  name           = "network-${var.name}"
  admin_state_up = "true"
}

resource "openstack_networking_subnet_v2" "public_subnet" {
  name = "${var.name}"
  network_id  = "${openstack_networking_network_v2.network.id}"
  cidr        = "${var.public_subnet_cidr}"
  ip_version  = 4
  enable_dhcp = "true"
  dns_nameservers = ["8.8.8.8"]
  allocation_pools {
    start = "${cidrhost("${var.public_subnet_cidr}","${var.begin_dhcp_pool}")}"
    end = "${cidrhost("${var.public_subnet_cidr}","${var.end_dhcp_pool}")}"
  }
}

resource "openstack_networking_port_v2" "public_net_interface_port" {
  admin_state_up = "true"
  name="port-${var.name}"
  network_id = "${openstack_networking_network_v2.network.id}"
  fixed_ip {
    subnet_id = "${openstack_networking_subnet_v2.public_subnet.id}"
  }
}

resource "openstack_networking_router_interface_v2" "public_net_dev_interface" {

  router_id = "${openstack_networking_router_v2.dev_net_router.id}"
  port_id = "${openstack_networking_port_v2.public_net_interface_port.id}"
}

