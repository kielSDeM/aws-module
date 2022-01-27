variable "region" {
  default = "#enter region here"
}
variable "public_cidr" {
  type    = list(string)
  default = ["128.0.0.1/24", "128.0.0.2/24", "128.0.0.3/24"]
}
variable "private_cidr" {
  type    = list(string)
  default = ["128.0.0.4/24", "128.0.0.5/24", "128.0.0.6/24"]
}
variable "vpc_cidr" {
  type    = string
  default = "128.0.0.0/16"
}
