source "amazon-ebs" "ubuntu" {
  ami_name      = "packer_AWS {{timestamp}}"
  instance_type = "t2.micro"
  region        = "us-west-2"

  source_ami_filter {
    filters = {
      virtualization-type = "hvm"
      name                = "ubuntu/images/*ubuntu-xenial-16.04-amd64-server-*"
      root-device-type    = "ebs"
    }
    owners      = ["099720109477"]
    most_recent = true
  }

  tags = {
    Name    = "ubuntu 16.04"
    projeto = "projeto x"
  }

  ssh_username = "ubuntu"
}

build {
  sources = ["source.amazon-ebs.ubuntu"]

  provisioner "shell" {
    inline = ["apt-get install -y sl"]
    only = ["ubuntu"]
  }
}

