output "ip" {
  value ="${openstack_compute_instance_v2.bastion.floating_ip}"
}
output "router_id"{
   value ="${openstack_networking_router_v2.dev_net_router.id}"
}

output "public_net_dev_router_interface_ip"{
  value = "${openstack_networking_port_v2.public_net_interface_port.fixed_ip}"
}

output "network_id"{
  value = "${openstack_networking_network_v2.network.id}"
}

output "public_subnet_id"{
  value = "${openstack_networking_subnet_v2.public_subnet.id}"
}



output "public_router_ip"{
  value = "${openstack_networking_router_v2.dev_net_router.external_gateway}"
}

output "public_subnet_gateway" {
  value = "${openstack_networking_subnet_v2.public_subnet.gateway_ip}"
}