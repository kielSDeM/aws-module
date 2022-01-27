variable "ssd" {
  type = map(string)
  default = {
    #general purpose ssd
    gp3 = "gp3"
    #general purpose ssd
    gp2 = "gp2"
    #general purpose ssd
    io2 = "io2"
    #general purpose ssd
    io1 = "io1"
  }
}
variable "hdd" {
  type = map(string)
  default = {
    #throughput optimized hdd
    st1 = "st1"
    #cold hdd
    sc1 = "sc1"
  }
}