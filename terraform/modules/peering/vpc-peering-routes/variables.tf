variable "route_table_ids" {
  type = list(string)
}

variable "destination_cidr_block" {
  type = string
}

variable "vpc_peering_connection_id" {
  type = string
}