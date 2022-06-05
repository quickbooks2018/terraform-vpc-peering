output "vpc-peering" {
  value = aws_vpc_peering_connection.vpc-peering
}

output "vpc-peering-connection-id" {
  value = aws_vpc_peering_connection.vpc-peering.id
}