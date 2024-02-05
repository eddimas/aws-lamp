variable "ami" {
  default = "ami-0277155c3f0ab2930"
}

variable "instance_type" {
  description = "value of the instance type."
}

variable "key_name" {
  description = "SSH Key used for the servers."
}

variable "subnet_id" {
  description = "Subnet ID information for the Web servers."
}

variable "vpc_id" {
  description = "VPC ID information for TF servers."
}

variable "environment" {
  description = "Environment"  
}