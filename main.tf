module "sg" {
  source       = "git@github.com:pipinokyo/tf-modules.git//SG-Module"
  vpc_id       = data.aws_vpc.default.id
  service_name = "sg"
  tags         = local.common_tags
}

module "rds" {
  source             = "git@github.com:pipinokyo/tf-modules.git//RDS-Module"
  db_name            = var.db_name
  db_username        = var.db_username
  db_password        = var.db_password
  instance_class     = "db.t3.micro"
  db_subnet_group    = data.aws_db_subnet_group.default.name
  security_group_id  = module.sg.rds_sg_id
  service_name       = "rds"
  tags               = local.common_tags
}

module "ec2" {
  source             = "git@github.com:pipinokyo/tf-modules.git//EC2-Module"
  ami_id             = data.aws_ami.amazon_linux.id
  instance_type      = var.instance_type
  key_name           = var.key_name
  security_group_ids = [module.sg.ec2_sg_id]
  service_name       = "ec2"
  tags               = local.common_tags
}

data "aws_vpc" "default" {
  default = true
}

data "aws_db_subnet_group" "default" {
  name = "default"
}

data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

output "ec2_public_ip" {
  value = module.ec2.public_ip
}

output "rds_endpoint" {
  value = module.rds.endpoint
}