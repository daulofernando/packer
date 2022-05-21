variables {
  region = "us-west-2"
  name = "packer_AWS {{timestamp}}"
}

source "amazon-ebs" "ubuntu" {
  ami_name      = var.name
  instance_type = "t2.micro"
  region        = var.region

  source_ami_filter {
    filters = {
      virtualization-type = "hvm"
      name                = "ubuntu/images/*ubuntu-focal-20.04-amd64-server-*"
      root-device-type    = "ebs"
    }
    owners      = ["099720109477"]
    most_recent = true
  }

  tags = {
    Name    = "ubuntu 20.04"
    esquema = "projeto x"
  }

  ssh_username = "ubuntu"
}

build {
  sources = ["source.amazon-ebs.ubuntu"]

  provisioner "shell" {
    script = "./script.sh" 
  }

  post-processor "manifest" {
    output = "outputs.json"
    strip_path = true
  }
}