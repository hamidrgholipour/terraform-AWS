variable "AMIS" {
  type = map
  default = {
    ubuntu = "ami-0fc5d935ebf8bc3bc"
    amazon = "ami-0230bd60aa48260c6"
  }
}

variable "os" {
  default = "amazon"
}

variable "instance_type" {
  default = "t2.micro"
}


variable "subnet_id" {
  type = string
}

variable "vpc_security_group_id" {
  type = list(string)
}

variable "keypair" {
  type = string
  default = "hamid"
}

variable "name" {
  type = string
}
