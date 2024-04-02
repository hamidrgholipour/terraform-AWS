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

variable "vpc_name" {
  type = string 
  default = "hamid_vpc"
}

variable "vpc_cidr_block" {
  type = string 
  default = "10.0.0.0/16"
}

variable "vpc_availability_zones" {
  type = list(string)
  default = ["us-east-1a", "us-east-1b"]
}

variable "vpc_public_subnets" {
  type = list(string)
  default = ["10.0.101.0/24", "10.0.102.0/24"]
}

variable "vpc_private_subnets" {
  type = list(string)
  default = ["10.0.0.0/24", "10.0.0.0/24"]
}