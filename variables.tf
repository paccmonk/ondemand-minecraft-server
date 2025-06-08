variable "vm_size" {
    type = string
    default = "t3.medium"
}

# variable "key_pair" {
#     type = string
#     default = "test_keypair2" # needs to be created beforehand
# }

variable "public_subnets_cidr" {
    type = list(string)
    description = "CIDR for public subnets"
    default = [ "10.0.1.0/24", "10.0.2.0/24" ]
}

variable "azs" {
    type = list(string)
    description = "AZs for subnets"
    default = [ "us-east-1a", "us-east-1b" ]
}