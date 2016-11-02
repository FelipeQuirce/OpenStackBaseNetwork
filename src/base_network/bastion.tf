resource "openstack_networking_port_v2" "port_bastion" {
  name = "port-bastion-${var.name}"
  admin_state_up = "true"
  network_id = "${openstack_networking_network_v2.network.id}"
  security_group_ids = [
    "${openstack_compute_secgroup_v2.sg_bastion.id}"]
  fixed_ip {
    subnet_id = "${openstack_networking_subnet_v2.public_subnet.id}"
  }
}

resource "openstack_compute_floatingip_v2" "bastion_ip" {
  pool = "${var.floating_ip_pool}"

}

resource "openstack_compute_instance_v2" "bastion" {
  name = "instance-bastion-${var.name}"
  image_name = "${var.bastion_image_name}"
  flavor_name = "${var.bastion_flavour_name}"
  security_groups = [
    "${openstack_compute_secgroup_v2.sg_bastion.name}"]
  key_pair = "${openstack_compute_keypair_v2.bastion_key.name}"
  floating_ip = "${openstack_compute_floatingip_v2.bastion_ip.address}"
  network {
    port = "${openstack_networking_port_v2.port_bastion.id}"
  }
  metadata {
    rol = "bastion"
    component = "${var.component}"
    tag = "${var.tag}"
  }
  availability_zone = "${var.availability_zone}"
}

resource "openstack_compute_secgroup_v2" "sg_bastion" {
  name = "seg-bastion-${var.name}"
  description = "my security group"
  rule {
    from_port = 22
    to_port = 22
    ip_protocol = "tcp"
    cidr = "0.0.0.0/0"
  }
  rule {
    from_port = -1
    to_port = -1
    ip_protocol = "icmp"
    cidr = "0.0.0.0/0"
  }
  rule {
    from_port = 53
    to_port = 53
    ip_protocol = "udp"
    cidr = "0.0.0.0/0"
  }
}


resource "openstack_compute_keypair_v2" "bastion_key" {
  name = "key-bastion-${var.name}"
  public_key = "${file(var.bastion_key_path)}"
}

