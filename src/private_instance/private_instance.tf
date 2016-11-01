 resource "openstack_compute_instance_v2" "private_machine" {
  name        =  "${var.machine_name}-${var.component}-${var.tag}"
  image_name = "${var.image_name}"
  flavor_name = "${var.flavour_name}"
  key_pair    =  "${openstack_compute_keypair_v2.private_key.name}"
  metadata {
    rol = "web"
    component= "${var.component}"
    tag = "${var.tag}"
  }
  network {
    port = "${openstack_networking_port_v2.private_machine_port.id}"
  }

  availability_zone = "${var.availability_zone}"
}


 resource "openstack_networking_port_v2" "private_machine_port" {
   name = "web-${var.component}-${var.tag}"
   admin_state_up = "true"
   network_id     = "${module.private_subnet.private_network}"
   security_group_ids = ["${var.security_group_id}"]
   fixed_ip{
     subnet_id = "${var.private_subnet_id}"
   }
 }
 resource "openstack_compute_keypair_v2" "private_key" {
   name = "keypair-${var.component}-${var.tag}"
   public_key = "${file(var.key_path)}"
 }


