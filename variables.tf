#
#
# Region
variable "myregion" {
  type = string
  default = "us-east-1"
  description = "The AWS Region"
}

# VPC
#
variable "var_vpc_id" {
  type = string
  default = "vpc-0b4f32ef53a79ea6c"
  description = "Assuming this is the vpc id provided"
}

# Public subnet | Subnet id 1
#
variable "var_subnet_id1" {
  type = string
  default = "subnet-09f78bd306fce4033"      # this subnet id is not a real one
  description = "Assuming this is a public subnet"
  Tags {

  }
}

# Public subnet | Subnet id 2
#
variable "var_subnet_id2" {
  type = string
  default = "subnet-0e3a476b68b9bbcb4"      # this subnet id is not a real one
  description = "Assuming this is another public subnet within the VPC"
}

#more subnets may be needed