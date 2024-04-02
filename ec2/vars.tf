variable REGION {
  default = "us-east-1"
}

variable ZONE1 {
  default = "us-east-1a"
}

variable ZONE2 {
  default = "us-east-1b"
}

variable ZONE3 {
  default = "us-east-1c"
}

variable AMIS {
  type = map
  default = {
    ubuntu = "ami-0fc5d935ebf8bc3bc"
    amazon = "ami-0230bd60aa48260c6"
  }
}

variable instance_type {
  default = "t2.micro"
}

variable os {
  default = "amazon"
}


variable "instance_keypair" {
  type = string
  default = "hamid"
}

variable "instance_count" {
  type= number
  default = 1
}

## VPC
variable "vpc_cidr_block" {
  description = "CIDR block for the VPC network"
  default     = "10.0.0.0/16"
  type        = string
}

variable subnet_pub {
  type = list(string)
  default = [ "10.0.1.0/24","10.0.2.0/24","10.0.3.0/24" ]
}

variable subnet_priv {
  type = list(string)
  default = [ "10.10.1.0/24","10.10.2.0/24","10.10.3.0/24" ]
}
