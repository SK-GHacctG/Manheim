#
#
# Region
#
variable "myregion" {
  type = string
  default = "us-east-1"
  description = "The AWS Region"
}

# VPC - Assuming this is the VPC provided
#
variable "var_vpc_id" {
  type = string
  default = "vpc-0b4f32ef53a79ea6c"        # The id is not a real one.
  description = "Assuming this is the vpc id provided"
}

# Public subnet | Subnet id 1
#
variable "var_subnet_id1" {
  type = string
  default = "subnet-09f78bd306fce4033"      # Assuming this is a subnet provided; the id is not a real one.
  description = "Assuming this is a public subnet"
}

# Public subnet | Subnet id 2
#
variable "var_subnet_id2" {
  type = string
  default = "subnet-0e3a476b68b9bbcb4"      # This subnet id is not a real one; assuming this is a subnet given.
  description = "Assuming this is another public subnet within the VPC"
}

# Private subnet | Subnet id 3
#
variable "var_subnet_id3" {
  type = string
  default = "subnet-0e3a476b68b9bbnm4"      # This subnet id is not a real one; assuming this is a subnet given.
  description = "Assuming this is another private subnet within the VPC"
}

# More subnets may be needed in real network
