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

variable "environment" {
  description = "Deployment environment"
  type        = string
}