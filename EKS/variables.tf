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

variable os {
  default = "amazon"
}

variable PUB_KEY {
  default = "hamidkey.pub"
}

variable PRIV_KEY {
  default = "hamidkey"
}

variable MYIP {
  default = "183.83.67.89/32"
}

variable "instance_keypair" {
  type = string
  default = "hamid-temp"
}

variable "instance_count" {
  type= number
  default = 1
}

