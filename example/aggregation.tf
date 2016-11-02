module "base_network" {
    source = "github.com/FelipeQuirce/OpenStackBaseNetwork?ref=2.0//src/base_network"
    tag                             = "${var.tag}"
    component                       = "${var.component}"
    bastion_key_path          = "${var.bastion_key_path}"
    lb_key_path               = "${var.lb_key_path}"
    public_subnet_cidr              = "${var.public_subnet_cidr_block}"
    tenant_dev_external_network_id  = "${var.dev_external_gateway_id}"
    begin_dhcp_pool                 = "${var.begin_dhcp_pool}"
    end_dhcp_pool                   = "${var.end_dhcp_pool}"
    floating_ip_pool                = "${var.public_floating_ip_pool}"
    availability_zone               = "${var.availability_zone}"
    bastion_image_name                = "${var.bastion_image_name}"
    name = "${var.component}-${var.tag}"
    bastion_flavour_name = "${var.bastion_flavour_name}"
    lb_image_name = "${var.lb_image_name}"
    lb_flavour_name = "${var.lb_flavour_name}"
    proxy_image_name = "${var.proxy_image_name}"
    proxy_flavour_name = "${var.proxy_flavour_name}"
    proxy_key_path               = "${var.proxy_key_path}"
    private_subnet_cidr_block       = "${var.private_subnet_cidr_block}"
}


module "web" {

  source = "github.com/FelipeQuirce/OpenStackBaseNetwork?ref=2.0//src/private_machine"
  tag                             = "${var.tag}"
  component                       = "${var.component}"
  flavour_name = "${var.web_flavour_name}"
  security_group_id = "${openstack_compute_secgroup_v2.web_seg.id}"
  availability_zone               = "${var.availability_zone}"
  machine_name = "web"
  key_path               = "${var.web_key_path}"
  private_network_id = "${module.base_network.private_network_id}"
  private_subnet_id = "${module.base_network.private_subnet_id}"
  image_name ="${var.rhel_image_name}"

}
module "worker-1" {

  source = "github.com/FelipeQuirce/OpenStackBaseNetwork?ref=2.0//src/private_machine"
  tag                             = "${var.tag}"
  component                       = "${var.component}"
  flavour_name = "${var.web_flavour_name}"
  security_group_id = "${openstack_compute_secgroup_v2.worker_seg.id}"
  availability_zone               = "${var.availability_zone}"
  machine_name = "worker-1"
  key_path               = "${var.worker_key_path}"
  private_network_id = "${module.base_network.private_network_id}"
  private_subnet_id = "${module.base_network.private_subnet_id}"
  image_name ="${var.rhel_image_name}"
}

