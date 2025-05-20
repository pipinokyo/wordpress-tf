variable "ami_id" {
  description = "AMI ID for the EC2 instance"
  type        = string
  default     = "" # You can set a default or leave empty to require input
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "key_name" {
  description = "Key pair name for EC2"
  type        = string
  default     = "ubuntu wsl"
}

variable "db_name" {
  description = "Database name"
  type        = string
  default     = "wordpressdb"
}

variable "db_username" {
  description = "Database username"
  type        = string
  default     = "admin"
}

variable "db_password" {
  description = "Database password"
  type        = string
  default     = "Wordpress123!"
}