
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


module "source_vpc" {
  source  = "registry.terraform.io/terraform-aws-modules/vpc/aws"
  version = "3.11.0"

  name            = "source-vpc"

  cidr            = "10.60.0.0/16"
  azs             = ["us-east-1a", "us-east-1b", "us-east-1c"]
  private_subnets = ["10.60.0.0/23", "10.60.2.0/23", "10.60.4.0/23"]
  public_subnets  = ["10.60.100.0/23", "10.60.102.0/24", "10.60.104.0/24"]


  map_public_ip_on_launch = true
  enable_nat_gateway      = true
  single_nat_gateway      = true
  one_nat_gateway_per_az  = false

  create_database_subnet_group           = true
  create_database_subnet_route_table     = true
  create_database_internet_gateway_route = false
  create_database_nat_gateway_route      = true

  enable_dns_hostnames = true
  enable_dns_support   = true


  private_subnet_tags = {
    source-vpc        = "yes"
  }

  public_subnet_tags = {
    source-vpc       = "yes"
  }


}


module "destination_vpc" {
  source  = "registry.terraform.io/terraform-aws-modules/vpc/aws"
  version = "3.11.0"

  name            = "destination-vpc"

  cidr            = "10.70.0.0/16"
  azs             = ["us-east-1a", "us-east-1b", "us-east-1c"]
  private_subnets = ["10.70.0.0/23", "10.70.2.0/23", "10.70.4.0/23"]
  public_subnets  = ["10.70.100.0/23", "10.70.102.0/24", "10.70.104.0/24"]


  map_public_ip_on_launch = true
  enable_nat_gateway      = true
  single_nat_gateway      = true
  one_nat_gateway_per_az  = false

  create_database_subnet_group           = true
  create_database_subnet_route_table     = true
  create_database_internet_gateway_route = false
  create_database_nat_gateway_route      = true

  enable_dns_hostnames = true
  enable_dns_support   = true


  private_subnet_tags = {
    destination-vpc   = "yes"
  }

  public_subnet_tags = {
    destination-vpc  = "yes"
  }


}
