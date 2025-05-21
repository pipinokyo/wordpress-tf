module "sg" {                                                                 # module is a Terraform keyword to call a reusable module. "sg" is the local name for this module instance (used to reference its outputs)
  source       = "git@github.com:pipinokyo/tf-modules.git//SG-Module"         # source is the location of the module. It points to a GitHub repository containing the module code.
  vpc_id       = data.aws_vpc.default.id                                      # vpc_id is the ID of the VPC where the security group will be created. It uses a data source to get the default VPC ID.
  service_name = "sg"                                                         # service_name is a custom variable passed to the module, likely used for tagging or naming.
  tags         = local.common_tags                                            # tags are the common tags defined in the locals block, passed to the module for resource tagging.
}

module "rds" {                                                                # module is a Terraform keyword to call a reusable module. "rds" is the local name for this module instance (used to reference its outputs)
  source             = "git@github.com:pipinokyo/tf-modules.git//RDS-Module"  # source is the location of the module. It points to a GitHub repository containing the module code.
  db_name            = var.db_name                                            # db_name is the name of the database to be created, passed as a variable. in this case, it is "wordpressdb".
  db_username        = var.db_username                                        # db_username is the username for the database, passed as a variable. in this case, it is "admin".
  db_password        = var.db_password                                        # db_password is the password for the database, passed as a variable. in this case, it is "Wordpress123!".
  instance_class     = "db.t3.micro"                                          # instance_class is the type of RDS instance to be created. in this case, it is "db.t3.micro".
  db_subnet_group    = data.aws_db_subnet_group.default.name                  # db_subnet_group is the name of the subnet group for the RDS instance, obtained from a data source.
  security_group_id  = module.sg.rds_sg_id                                    # security_group_id is the ID of the security group to be associated with the RDS instance, obtained from the sg module.
  service_name       = "rds"                                                  # service_name is a custom variable passed to the module, likely used for tagging or naming.
  tags               = local.common_tags        
} 

module "ec2" {                                                                # module is a Terraform keyword to call a reusable module. "ec2" is the local name for this module instance (used to reference its outputs)
  source             = "git@github.com:pipinokyo/tf-modules.git//EC2-Module"  # source is the location of the module. It points to a GitHub repository containing the module code.
  ami_id             = data.aws_ami.amazon_linux.id                           # ami_id is the ID of the Amazon Machine Image (AMI) to be used for the EC2 instance, obtained from a data source.
  instance_type      = var.instance_type                                      # instance_type is the type of EC2 instance to be created, passed as a variable. in this case, it is "t2.micro".
  key_name           = var.key_name                                           # key_name is the name of the key pair to be used for SSH access to the EC2 instance, passed as a variable.
  security_group_ids = [module.sg.ec2_sg_id]                                  # security_group_ids is a list of security group IDs to be associated with the EC2 instance, obtained from the sg module.
  service_name       = "ec2"                                                  # service_name is a custom variable passed to the module, likely used for tagging or naming.
  tags               = local.common_tags
}

data "aws_vpc" "default" {                                                    # data is a Terraform keyword to define a data source. "aws_vpc" is the type of data source, and "default" is the local name for this data source instance.   
  default = true
}

data "aws_db_subnet_group" "default" {                                        # data is a Terraform keyword to define a data source. "aws_db_subnet_group" is the type of data source, and "default" is the local name for this data source instance.
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