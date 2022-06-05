resource "aws_vpc_peering_connection" "vpc-peering" {
  peer_owner_id = var.aws_account_id
  peer_vpc_id   = var.peer_vpc_id
  vpc_id        = var.this_vpc_id
  auto_accept   = var.auto_accept_peering

  accepter {
    allow_remote_vpc_dns_resolution = var.allow_remote_vpc_dns_resolution
  }

  requester {
    allow_remote_vpc_dns_resolution = var.allow_remote_vpc_dns_resolution
  }

  tags = {
    Name = var.peering_tag
  }
}

