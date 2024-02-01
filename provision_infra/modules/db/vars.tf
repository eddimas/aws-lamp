variable "ami" {
  default = "ami-09bc2dbe2c34252d3"
}

variable "key_name" {
  description = "SSH Key used for the servers."
}

variable "subnet_id" {
  description = "Subnet ID information for the DB servers."
}

variable "vpc_id" {
  description = "VPC ID information for TF servers."
}

variable "sg_tf_web" {
  description = "Web Server Security group ID"
}

variable "environment" {
  description = "Environment"
}