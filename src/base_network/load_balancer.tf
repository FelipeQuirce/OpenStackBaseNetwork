resource "openstack_networking_port_v2" "port_lb" {
  name = "port-lb-${var.name}"
  admin_state_up = "true"
  network_id     = "${openstack_networking_network_v2.network.id}"
  security_group_ids = ["${openstack_compute_secgroup_v2.sg_lb.id}"]
  fixed_ip {
    subnet_id = "${openstack_networking_subnet_v2.public_subnet.id}"
  }
}

resource "openstack_compute_floatingip_v2" "lb_ip" {
  pool = "${var.floating_ip_pool}"

}

resource "openstack_compute_instance_v2" "lb" {
  name        =  "instance-lb-${var.name}"
  image_name = "${var.lb_image_name}"
  flavor_name = "${var.lb_flavour_name}"
  key_pair    =  "${openstack_compute_keypair_v2.lb_key.name}"
  floating_ip = "${openstack_compute_floatingip_v2.lb_ip.address}"
  security_groups = ["${openstack_compute_secgroup_v2.sg_lb.name}"]

  network {
    port = "${openstack_networking_port_v2.port_lb.id}"
  }
  metadata {
    rol = "lb"
    component= "${var.component}"
    tag = "${var.tag}"
  }
  availability_zone = "${var.availability_zone}"
}

resource "openstack_compute_secgroup_v2" "sg_lb" {
  name = "sec-lb-${var.name}"
  description = "my security group"
  rule {
    from_port = 22
    to_port = 22
    ip_protocol = "tcp"
    cidr = "10.0.0.0/8"
  }
  rule {
    from_port = 80
    to_port = 80
    ip_protocol = "tcp"
    cidr = "0.0.0.0/0"
  }
  rule {
    from_port = 443
    to_port = 443
    ip_protocol = "tcp"
    cidr = "0.0.0.0/0"
  }

  rule {
    from_port = -1
    to_port = -1
    ip_protocol = "icmp"
    cidr = "0.0.0.0/0"
  }

}


resource "openstack_compute_keypair_v2" "lb_key" {
  name = "key-lb-${var.name}"
  public_key = "${file(var.lb_key_path)}"
}