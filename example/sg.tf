resource "openstack_compute_secgroup_v2" "web_seg" {
  name = "web-seg-${var.component}-${var.tag}"
  description = "my security group"
  rule {
    from_port = 22
    to_port = 22
    ip_protocol = "tcp"
    cidr = "${var.public_subnet_cidr_block}"
  }
  rule {
    from_port = 443
    to_port = 443
    ip_protocol = "tcp"
    cidr = "${var.public_subnet_cidr_block}"
  }
  rule {
    from_port = 2222
    to_port = 2222
    ip_protocol = "tcp"
    cidr = "${var.private_subnet_cidr_block}"
  }

  rule {
    from_port = -1
    to_port = -1
    ip_protocol = "icmp"
    cidr = "10.10.0.0/16"
  }

  rule {
    from_port = 9100
    to_port = 9100
    ip_protocol = "tcp"
    cidr = "10.10.0.0/16"
  }


}



resource "openstack_compute_secgroup_v2" "worker_seg" {
  name = "worker-seg-${var.component}-${var.tag}"
  description = "my security group"
  rule {
    from_port = 22
    to_port = 22
    ip_protocol = "tcp"
    cidr = "${var.public_subnet_cidr_block}"
  }

  rule {
    from_port = -1
    to_port = -1
    ip_protocol = "icmp"
    cidr = "10.10.0.0/16"
  }
  rule {
    from_port = 7777
    to_port = 7777
    ip_protocol = "tcp"
    cidr = "${var.private_subnet_cidr_block}"
  }
  rule {
    from_port = 7788
    to_port = 7788
    ip_protocol = "tcp"
    cidr = "${var.private_subnet_cidr_block}"
  }

  rule {
    from_port = 9100
    to_port = 9100
    ip_protocol = "tcp"
    cidr = "10.10.0.0/16"
  }


}