
data "aws_vpc" "hamid_vpc" {
  filter  {
    name = "tag:Name"
    values = ["hamid-vpc"]
    }
}

data "aws_subnet" "public_subnet_1" {
  filter {
    name = "tag:Name"
    values = ["hamid-vpc-public-us-east-1a"]
  }
}

data "aws_subnet" "public_subnet_2" {
  filter {
    name = "tag:Name"
    values = ["hamid-vpc-public-us-east-1b"]
  }
}