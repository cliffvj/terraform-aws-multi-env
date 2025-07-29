variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}

variable vpc_id {
  description = "VPC ID where EC2 will be launched"
  type        = string
}

variable "ssh_allowed_cidr" { 
  description = "valid CIDR block for SSH access"
  type = string 
  default = "0.0.0.0/0"
  }

variable "tags" {
  description = "Tags for resources"
  type        = map(string)
  default     = {}
}

variable "environment" {
  description = "Deployment environment"
  type        = string
}

variable "cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "subnet_id" {
  description = "Subnet where EC2 will be placed"
  type        = string
}

variable "shared_sg_id" {
  description = "ID of the shared security group"
  type        = string
}