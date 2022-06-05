variable "aws_account_id" {
  type = string
}

variable "this_vpc_id" {
  type = string
}

variable "peer_vpc_id" {
  type = string
}

variable "auto_accept_peering" {
  type = string
}

variable "allow_remote_vpc_dns_resolution" {
  type = string
}

variable "peering_tag" {
  type = string
}