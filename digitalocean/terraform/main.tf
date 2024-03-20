data "digitalocean_ssh_key" "default" {
  name = "terraform"
}

data "local_file" "idk" {
  filename = "${path.module}/init.sh"
}

resource "digitalocean_droplet" "jenkins-master" {
  image     = "ubuntu-20-04-x64"
  name      = "jenkins-master"
  region    = "fra1"
  size      = "s-1vcpu-1gb"
  ssh_keys  = [data.digitalocean_ssh_key.default.fingerprint]
  user_data = data.local_file.idk.content
}

output "droplet_ip_addresses" {
  value = digitalocean_droplet.jenkins-master.ipv4_address
}

