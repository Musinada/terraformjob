variable "linux_ami_id" {
    description = "ami id of the linux machine"
    default = "ami-052efd3df9dad4825"
}
variable "vpc_id" {
    description = "vpc_id under which the resource group will create"
    default = "vpc-082485d83a32d7336"
}
variable "subnet" {
    description = "subnet id of the vpc"
    default = "	subnet-0b09b80c31a47edbf"
}
variable "cidr_blocks" {
    description = "subnet ip range in cidr block"
    default = ["0.0.0.0/0"]
}

variable "region" {
    description = "aws region"
    default = "us-east-1"
}
variable "volume_type" {
    description = "type of the storage"
    default = "gp2"
}
