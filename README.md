# LAMP Stack in AWS

## Summary

This project is designed to create a LAMP stack with their own VPC and network components.
First part is to create a VPC with 1 public, 1 private subnet.
Second part is to provision a basic php page using apache server.

## Prerequisites

1. SSH key pair should be created and mentioned in provision_infra/vars.tf
2. Modify the ~/.ssh/config file to include the below lines.

```bash
Host bastion
   User ec2-user
   IdentityFile ~/.ssh/myNewKey
   Hostname <ec2-publicInstanceIP>

Host apache
   User ec2-user
   IdentityFile ~/.ssh/myNewKey
   Hostname <ec2-publicInstanceIP>

Host mysql
   User ec2-user
   Hostname <ec2-privateInstanceIP>
   IdentityFile ~/.ssh/myNewKey
   ProxyCommand ssh -q -W %h:%p bastion
```

3. These .pem key will be stored in the setup_lamp/ folder

## Terraform

Go into the provision_infra folder and run the below commands to create the infrastructure.

```bash
terraform init
terraform get
terraform plan
terraform apply
```

### Instances

Get the public IP of the web server and use it in the setup_lamp/inventory file.

## Ansible Playbook

Modify the inventory file with the web server IP and run the below command to create a simple php page using apache server.

```bash
ansible-playbook -i inventory playbook.yaml
```

## Output

Sample output is shown below.

```bash
curl -iv http://54.159.201.71/page.php
*   Trying 54.159.201.71:80...
* Connected to 54.159.201.71 (54.159.201.71) port 80 (#0)
> GET /page.php HTTP/1.1
> Host: 54.159.201.71
> User-Agent: curl/7.81.0
> Accept: */*
>
* Mark bundle as not supporting multiuse
< HTTP/1.1 200 OK
HTTP/1.1 200 OK
< Date: Thu, 01 Feb 2024 23:52:49 GMT
Date: Thu, 01 Feb 2024 23:52:49 GMT
< Server: Apache/2.4.58 (Amazon Linux)
Server: Apache/2.4.58 (Amazon Linux)
< Transfer-Encoding: chunked
Transfer-Encoding: chunked
< Content-Type: text/html; charset=UTF-8
Content-Type: text/html; charset=UTF-8

<
<!DOCTYPE html>
<html>
<head>
    <title>Simple PHP Page</title>
</head>
<body>
    <h1>Welcome to my PHP Page!</h1>
    <p>Current Date and Time: 2024-02-01 23:52:49</p></body>
* Connection #0 to host 54.159.201.71 left intact
</html>%
```
