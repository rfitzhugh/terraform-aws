## =============================================================================
#  Variables - AWS Access                                                      #
## =============================================================================
variable "AWS_ACCESS_KEY" {}
variable "AWS_SECRET_KEY" {}
variable "AWS_REGION" {
  default = "us-east-1"
}

## =============================================================================
#  Variables - AMIs                                                            #
## =============================================================================
variable "WIN_AMIS" {
  type = "map"
  default = {
    us-east-1 = "ami-06a4e829b8bbad61e"
    us-west-2 = "ami-9f5efbff"
    eu-west-1 = "ami-7ac78809"
  }
}

## =============================================================================
#  Variables - Environmental                                                   #
## =============================================================================
variable "PATH_TO_PRIVATE_KEY" {
  default = "mykey"
}
variable "PATH_TO_PUBLIC_KEY" {
  default = "mykey.pub"
}
variable "INSTANCE_USERNAME" {
  default = "Terraform"
}
variable "INSTANCE_PASSWORD" { }