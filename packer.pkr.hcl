source "amazon-ebs" "ubuntu" {
  ssh_username = "ubuntu"
  ami_name      = var.ami_name
  instance_type = var.instance_type 
  region        = var.region

  tags = {
    Name    = "ubuntu 20.04"
    Base_AMI_Name = "{{ .SourceAMIName }}"
    Release = var.release
  }

  source_ami_filter {
    filters = {
      virtualization-type = "hvm"
      name                = "ubuntu/images/*ubuntu-focal-20.04-amd64-server-*"
      root-device-type    = "ebs"
    }
    owners      = ["099720109477"]
    most_recent = true
  }
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