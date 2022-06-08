
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.7.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

terraform {
  required_version = "~> 1.0"
}


locals {
  aws_account_id              = "281624143694"
  source_vpc_id               = "vpc-052e1ada0be0b9ee1"
  destination_vpc_id          = "vpc-030e35282c4a2b79c"
  peering_tag                 = "vpc-peering"
  source_route_table_ids      = ["rtb-018ba3fa0e7d8159a","rtb-006d4071b5ba82ad9"]
  destination_route_table_ids = ["rtb-0f87758873912fa91","rtb-01f0d591d82d416d1"]
  destination_cidr_block      = "10.70.0.0/16"
  source_cidr_block           = "10.60.0.0/16"
}

#############
# Vpc Peering
##############
module "vpc-peering" {
  source = "../modules/peering/vpc-peering"
aws_account_id                  = local.aws_account_id
this_vpc_id                     = local.source_vpc_id
peer_vpc_id                     = local.destination_vpc_id
auto_accept_peering             = true
allow_remote_vpc_dns_resolution = true
peering_tag                     = local.peering_tag
}

################
# Peering Routes
################
module "peering-source-routes" {
  source = "../modules/peering/vpc-peering-routes"
  route_table_ids           = local.source_route_table_ids
  destination_cidr_block    = local.destination_cidr_block
  vpc_peering_connection_id = module.vpc-peering.vpc-peering-connection-id
  depends_on                = [module.vpc-peering]
}

module "peering-destination-routes" {
  source = "../modules/peering/vpc-peering-routes"
  route_table_ids           = local.destination_route_table_ids
  destination_cidr_block    = local.source_cidr_block
  vpc_peering_connection_id = module.vpc-peering.vpc-peering-connection-id
  depends_on                = [module.vpc-peering]
}
