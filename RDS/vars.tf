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
    amazon = "ami-0230bd60aa48260c6"
    ubuntu = "ami-0fc5d935ebf8bc3bc"
  }
}

variable USER {
  default = "ec2-user"
}



variable "target_port" {
  type = string
  default = "80"
}

variable "target_protocol" {
  type = string
  default = "HTTP"
}

variable "db_user" {
  type = string
  default = "root"
}

variable "db_pass" {
  type = string
}

variable "instance_keypair" {
  type = string
  default = "hamid"
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
