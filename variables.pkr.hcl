variable "region" {
    type = string
}

variable "ami_name" {
    type = string
    default = "packer_AWS {{timestamp}}"
}

variable "release" {
    type = string
    # default = "1.0"
}

variable "instance_type" {
    type = string
    default = "t2.micro"
}