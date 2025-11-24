variable "cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "tags" {
  description = "Tags for resources"
  type        = map(string)
  default     = {}
}

variable ssh_allowed_cidr {
  description = "Valid CIDR block for SSH access"
  type        = string
  default     = "" 
}

variable "prefix_list_ids" {
  description = "List of prefix list IDs for EC2 Instance Connect"
  type        = list(string)
  default     = ["pl-0e4bcff02b13bef1e"] # Example for us-east-1
}

variable "environment" {
  description = "Deployment environment"
  type        = string
}