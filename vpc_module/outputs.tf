output "vpc_out" {
  description = "the vpc"
  value       = aws_vpc.us_east_vpc
  sensitive   = true
}
output "vpc_out_cidr" {
  description = "the vpc cidr"
  value       = aws_vpc.us_east_vpc.cidr_block
  sensitive   = true
}
output "pub_sub_out" {
  description = "the public subnet."
  value       = aws_subnet.public_subnet1
  sensitive   = true
}
output "pub_sub_out_cidr" {
  description = "the public subnet cidr"
  value       = aws_subnet.public_subnet1.cidr_block
  sensitive   = true
}
output "priv_sub_out" {
  description = "the private subnet"
  value       = aws_subnet.private_subnet1
  sensitive   = true
}
output "priv_sub_out_cidr" {
  description = "the private subnet cidr"
  value       = aws_subnet.public_subnet1.cidr_block
  sensitive   = true
}