variable "az_count" {
  type    = number
  default = 2
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "key_name" {
  type    = string
  default = "dawan"
}

variable "root_volume_size" {
  type    = string
  default = "3"
}

# variable "default_tags" {
#   type = map(any)
#   default = {
#     "company_name" : "xyz"
#     "business_unit" : "IT"
#     "support_email" : "abc@xyz.com"
#   }
# }