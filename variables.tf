# Environment Variables
variable "env" {
  description = "Environment name (dev, staging, prod)"
  type        = string
  default     = "dev"
}

variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

# Project Variables
variable "project" {
  description = "Project name"
  type        = string
  default     = "wordpress-tf"
}

variable "business_unit" {
  description = "Business unit name"
  type        = string
  default     = "wordpress"
}

variable "tier" {
  description = "Application tier"
  type        = string
  default     = "backend"
}

variable "service_name" {
  description = "Service name (e.g., ec2, rds, sg)"
  type        = string
  default     = "ec2"
}

# Resource Variables
variable "instance_type" {
  description = "Type of instance to create"
  type        = string
  default     = "t2.micro"
}

variable "key_name" {
  description = "Key pair name for EC2"
  type        = string
  default     = "ubuntu wsl"
}

# Database Variables
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

# Tag Variables
variable "team" {
  description = "Team name"
  type        = string
  default     = "DevOps"
}

variable "owner" {
  description = "Owner email"
  type        = string
  default     = "cuneyt.omer@gmail.com"
}

variable "provider_name" {
  description = "Cloud provider name"
  type        = string
  default     = "aws"
}

variable "managed_by" {
  description = "Managed by"
  type        = string
  default     = "terraform"
}