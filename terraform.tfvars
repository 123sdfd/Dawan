#The Region you want to deploy the infra
aws_region         = "eu-west-3"

# Replace the VPC cidr from your account. Range of CIDR max(22)
vpc_cidr           = "172.168.96.0/22"

# Key pair name create in same region
key_name           = "dawan"

# personal laptop public ip for debugging and SSH purpose
personal_laptop_ip = "78.125.143.214"