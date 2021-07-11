variable "AWS_ACCESS_KEY" {}

variable "AWS_SECRET_KEY" {}

variable "AWS_REGION" {
    default = "us-east-1"
}

variable "AMIS" {
    type = map(string)
    default = {
        us-east-1: "ami-09e67e426f25ce0d7"
    }
}
