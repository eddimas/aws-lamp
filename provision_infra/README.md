# Terraform - LAMP Stack in AWS

## Summary

Terraform template create a LAMP stack with their own VPC and network components.

## Prerequisites

SSH key pair should be created and mentioned in vars.tf.

## Terraform

### Network

VPC with 1 public, 1 private subnet.
Subnets are one for Web Servers and another one is for DB Servers.
Security groups for each Servers.

### Instances

2 Amazon Linux Instances with existing SSH keys.

## How to run

Make sure that you have a SSH key and mentioned in vars.tf.

Change the AWS region in vars.tf to your proferred one.

Use the below commands to build, review and execute.

terraform init  
terraform get  
terraform plan  
terraform apply

## Output

Web Server IP and DB Server IP will be displayed as output.
