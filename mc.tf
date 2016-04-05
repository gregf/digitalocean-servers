# Set the variable value in *.tfvars file
variable "do_token" {}
variable "pub_key" {}
variable "pvt_key" {}
variable "ssh_fingerprint" {}

# Configure the DigitalOcean Provider
provider "digitalocean" {
    token = "${var.do_token}"
}

connection {
  user = "root"
  type = "ssh"
  key_file = "${var.pvt_key}"
  timeout = "2m"
}

provisioner "remote-exec" {
	inline = [
		"apt-get update",
		"apt-get upgrade -y",
		"apt-get dist-upgrade -y"
		"apt-get install -y sudo"
		"reboot"
	]
}

resource "digitalocean_droplet" "minecraft" {
  image = "debian-8-3-x64"
  name = "mc.gregf.org"
  region = "nyc3"
  size = "1gb"
  ipv6 = true
  private_networking = true
  ssh_keys = [
    "${var.ssh_fingerprint}"
  ]
}
