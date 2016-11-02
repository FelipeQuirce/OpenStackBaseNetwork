
variable "bastion_key_path" {
}

variable "web_key_path" {

}
variable "worker_key_path"{

}

variable "component" {
  default = "my-component"
}

variable "tag" {
  default = "simeone"
}


variable "public_subnet_cidr_block"{
  default = "10.10.90.0/24"
}

variable "private_subnet_cidr_block"{
  default = "10.10.91.0/24"
}


variable "bastion_image_name" {

}

variable "public_floating_ip_pool" {
}

variable "dev_external_gateway_id"{

}

variable "begin_dhcp_pool"{
  default = "10"
}

variable "end_dhcp_pool"{
  default = "200"
}

variable "availability_zone" {
}

variable "rhel_image_name" {
}

variable "bastion_flavour_name" {

}

variable "lb_image_name" {

}

variable "lb_flavour_name" {

}

variable "lb_key_path" {

}

variable "proxy_image_name" {

}

variable "proxy_flavour_name" {

}

variable "proxy_key_path" {

}

variable "web_flavour_name"{

}