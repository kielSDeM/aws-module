variable "region" {
  default = "us-east-1"
}

variable "us_east_az" {
  type    = list(string)
  default = ["us-east-1a", "us-east-1b", "us-east-1c"]
}
variable "us_west_az" {
  type    = list(string)
  default = ["us-west-1a", "us-west-1b", "us-west-1b"]
}