# Set the variable value in *.tfvars file
# or using -var="do_token=..." CLI option
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
}

resource "digitalocean_droplet" "monitoring" {
    image = "debian-8-3-x64"
    name = "mon.gregf.org"
    region = "nyc3"
    size = "1gb"
		ipv6 = true
		private_networking = true
		user_data "#!/bin/bash\n apt-get update -y\n apt-get upgrade -y\n apt-get install sudo"
    ssh_keys = [
      "${var.ssh_fingerprint}"
    ]
}

resource "digitalocean_droplet" "web" {
    image = "debian-8-3-x64"
    name = "www.gregf.org"
    region = "nyc3"
    size = "1gb"
		ipv6 = true
		private_networking = true
		user_data "#!/bin/bash\n apt-get update -y\n apt-get upgrade -y\n apt-get install sudo"
    ssh_keys = [
      "${var.ssh_fingerprint}"
    ]

}

resource "digitalocean_droplet" "db" {
    image = "debian-8-3-x64"
    name = "db.gregf.org"
    region = "nyc3"
    size = "512mb"
		ipv6 = false
		private_networking = true
		user_data "#!/bin/bash\n apt-get update -y\n apt-get upgrade -y\n apt-get install sudo"
    ssh_keys = [
      "${var.ssh_fingerprint}"
    ]

}

resource "digitalocean_droplet" "xmpp" {
    image = "debian-8-3-x64"
    name = "xmpp.gregf.org"
    region = "nyc3"
    size = "512mb"
		ipv6 = false
		private_networking = true
		user_data "#!/bin/bash\n apt-get update -y\n apt-get upgrade -y\n apt-get install sudo"
    ssh_keys = [
      "${var.ssh_fingerprint}"
    ]
}

resource "digitalocean_droplet" "7dtd" {
    image = "debian-8-3-x64"
    name = "7dtd.gregf.org"
    region = "nyc3"
    size = "2gb"
		ipv6 = true
		private_networking = true
		user_data "#!/bin/bash\n apt-get update -y\n apt-get upgrade -y\n apt-get install sudo"
    ssh_keys = [
      "${var.ssh_fingerprint}"
    ]
}
