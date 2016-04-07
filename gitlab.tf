resource "digitalocean_droplet" "gitlab" {
  image = "16403786"
  name = "gitlab.gregf.org"
  region = "nyc3"
  size = "1gb"
  ipv6 = true
  private_networking = true
  ssh_keys = [
    "${var.ssh_fingerprint}"
  ]
  provisioner "remote-exec" {
    inline = [
      "apt-get update",
      "apt-get upgrade -y",
      "apt-get dist-upgrade -y",
      "apt-get install -y sudo",
      "reboot"
    ]
  }
  connection {
    user = "root"
    type = "ssh"
    key_file = "${var.pvt_key}"
    timeout = "2m"
  }
}