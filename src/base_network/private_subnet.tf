resource "openstack_networking_network_v2" "private_network" {
  name           = "network-${var.name}"
  admin_state_up = "true"

}

resource "openstack_networking_subnet_v2" "private_subnet" {
  name = "${var.name}"
  network_id  = "${openstack_networking_network_v2.private_network.id}"
  cidr        = "${var.private_subnet_cidr_block}"
  ip_version  = 4
  enable_dhcp = "true"
  allocation_pools {
    start = "${cidrhost("${var.private_subnet_cidr_block}","${var.begin_dhcp_pool}")}"
    end = "${cidrhost("${var.private_subnet_cidr_block}","${var.end_dhcp_pool}")}"
  }
  dns_nameservers = ["8.8.8.8"]

}

resource "openstack_networking_router_v2" "dev_private_gateway_router" {
  admin_state_up = "true"
  name = "router-${var.name}"

}


resource "openstack_networking_router_interface_v2" "public_net_gateway_interface" {
  router_id = "${openstack_networking_router_v2.dev_private_gateway_router.id}"
  subnet_id = "${openstack_networking_subnet_v2.private_subnet.id}"


}


resource "openstack_networking_router_interface_v2" "private_to_gateway_interface" {
  router_id = "${openstack_networking_router_v2.dev_private_gateway_router.id}"
  subnet_id = "${openstack_networking_subnet_v2.public_subnet.id}"

}



output "private_network"{
  value = "${openstack_networking_network_v2.private_network.id}"
}

output "private_subnet_id"{
  value = "${openstack_networking_subnet_v2.private_subnet.id}"
}

output "private_subnet_name"{
  value = "${openstack_networking_subnet_v2.private_subnet.name}"
}

