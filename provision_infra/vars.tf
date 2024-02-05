variable "region" {
  default = "us-east-1"
}

variable "key_name" {
  default = "myNewKey"
}

variable "environment" {
  default = "dev"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "vpc_cidr" {
  default = "192.168.0.0/16"
}

variable "public_subnet_cidr" {
  default = "192.168.1.0/24"
}

variable "private_subnet_cidr" {
  default = "192.168.2.0/24"
}

variable "availability_zone_1" {
  default = "us-east-1a"
}

variable "availability_zone_2" {
  default = "us-east-1b"
}