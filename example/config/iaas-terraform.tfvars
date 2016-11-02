bastion_image_name="CENTOS_7.2"
rhel_image_name="CENTOS_7.2"
lb_image_name="CENTOS_7.2"
proxy_image_name="CENTOS_7.2"


proxy_flavour_name="m1.small"
bastion_flavour_name="m1.small"
lb_flavour_name="m1.small"
web_flavour_name="m1.medium"
worker_flavour_name="m1.medium"


availability_zone="I-1"
dev_external_gateway_id="f"
public_floating_ip_pool="DEV"


bastion_key_path="secrets/keys/openstack/bastion/ssh.public"
web_key_path="secrets/keys/openstack/machine/ssh.public"
lb_key_path="secrets/keys/openstack/machine/ssh.public"
proxy_key_path="secrets/keys/openstack/machine/ssh.public"
worker_key_path="secrets/keys/openstack/machine/ssh.public"


