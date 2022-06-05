resource "aws_route" "routes" {
  for_each                             = toset(var.route_table_ids)
  route_table_id                       = each.key
  destination_cidr_block               = var.destination_cidr_block
  vpc_peering_connection_id            = var.vpc_peering_connection_id
}