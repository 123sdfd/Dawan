variable "aws_region" {
  description = "AWS region"
  type    = string
  default = "eu-west-3"
}

variable "key_name" {
  type    = string
  default = "dawan"
  sensitive = true
}

variable "personal_laptop_ip" {
  type    = string
  default = "78.125.143.214"
}



# webserver variables

variable "az_count" {
  type    = number
  default = 2
}

variable "instance_type" {
  description = "Instance type for EC2 instances"
  type    = string
  default = "t2.micro"
}

variable "root_volume_size" {
  type    = string
  default = "10"
}

# variable "default_tags" {
#   type = map(any)
#   default = {
#     "company_name" : "xyz"
#     "business_unit" : "IT"
#     "support_email" : "abc@xyz.com"
#   }
# }


# network variables

variable "vpc_cidr" {
  type = string
  default = "10.0.0.0/16"
}

#
variable "multi_az_db" {
  type    = bool
  default = true
}


