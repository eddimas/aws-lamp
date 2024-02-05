# Configure the AWS Provider
provider "aws" {
  region = var.region
}

module "web" {
  source      = "./modules/web"
  key_name    = var.key_name
  instance_type = var.instance_type
  subnet_id   = aws_subnet.tf-public-subnet.id
  vpc_id      = aws_vpc.tf-vpc.id
  environment = var.environment
}

module "db" {
  source      = "./modules/db"
  key_name    = var.key_name
  instance_type = var.instance_type
  subnet_id   = aws_subnet.tf-private-subnet.id
  vpc_id      = aws_vpc.tf-vpc.id
  sg_tf_web   = module.web.sg_tf_web
  environment = var.environment
}
