resource "aws_instance" "demo_terraform-01" {
    instance_type = "t2.micro"
    ami = "${var.AMIS["${var.AWS_REGION}"]}"
}
