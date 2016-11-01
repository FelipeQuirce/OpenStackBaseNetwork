resource "openstack_networking_router_v2" "dev_net_router" {
  name = "router-${var.name}"
  admin_state_up = "true"
  external_gateway = "${var.tenant_dev_external_network_id}"
}


