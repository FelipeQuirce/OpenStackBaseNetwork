resource "openstack_networking_port_v2" "port_proxy" {
  name = "port-proxy-${var.name}"
  admin_state_up = "true"
  network_id = "${openstack_networking_network_v2.network.id}"
  security_group_ids = [
    "${openstack_compute_secgroup_v2.sg_proxy.id}"]
  fixed_ip {
    subnet_id = "${openstack_networking_subnet_v2.public_subnet.id}"
  }
}

resource "openstack_compute_floatingip_v2" "proxy_ip" {
  pool = "${var.floating_ip_pool}"

}

resource "openstack_compute_instance_v2" "proxy" {
  name = "instance-proxy-${var.name}"
  image_id = "${var.proxy_image_id}"
  flavor_name = "${var.proxy_flavour_name}"
  security_groups = [
    "${openstack_compute_secgroup_v2.sg_proxy.name}"]
  key_pair = "${openstack_compute_keypair_v2.proxy_key.name}"
  floating_ip = "${openstack_compute_floatingip_v2.proxy_ip.address}"
  network {
    port = "${openstack_networking_port_v2.port_proxy.id}"
  }
  metadata {
    rol = "proxy"
    component = "${var.component}"
    tag = "${var.tag}"
  }
  availability_zone = "${var.availability_zone}"
}

resource "openstack_compute_secgroup_v2" "sg_proxy" {
  name = "seg-proxy-${var.name}"
  description = "my security group"
  rule {
    from_port = 22
    to_port = 22
    ip_protocol = "tcp"
    cidr = "0.0.0.0/0"
  }
  rule {
    from_port = 3128
    to_port = 3128
    ip_protocol = "tcp"
    cidr = "10.0.0.0/8"
  }
  rule {
    from_port = 80
    to_port = 80
    ip_protocol = "tcp"
    cidr = "10.0.0.0/8"
  }
  rule {
    from_port = 443
    to_port = 443
    ip_protocol = "tcp"
    cidr = "10.0.0.0/8"
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
    ip_protocol = "tcp"
    cidr = "0.0.0.0/0"
  }
  rule {
    from_port = 53
    to_port = 53
    ip_protocol = "udp"
    cidr = "0.0.0.0/0"
  }
}


resource "openstack_compute_keypair_v2" "proxy_key" {
  name = "key-proxy-${var.name}"
  public_key = "${file(var.lb_key_path)}"
}