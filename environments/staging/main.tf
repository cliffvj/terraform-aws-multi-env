module "network" {
  source     = "../../modules/network"
  cidr_block = var.vpc_cidr
  ssh_allowed_cidr = var.ssh_allowed_cidr != "" ? var.ssh_allowed_cidr : local.my_ip_cidr
  environment   = var.environment
  tags       = merge(local.common_tags, { Environment = "staging" })
}

module "compute" {
  source        = "../../modules/compute"
  cidr_block = var.vpc_cidr
  instance_type = var.instance_type
  environment   = var.environment
  vpc_id = module.network.vpc_main_id
  shared_sg_id = module.network.shared_sg_id
  subnet_id  = module.network.public_subnet_id
  tags          = merge(local.common_tags, { Environment = "staging" })
}

data "http" "my_ip" {
  url = "https://checkip.amazonaws.com/"
}

locals {
  my_ip_cidr = "${chomp(data.http.my_ip.response_body)}/32"

  common_tags = {
    Project = "MyApp"
    Owner   = "DevOps"
  }
}