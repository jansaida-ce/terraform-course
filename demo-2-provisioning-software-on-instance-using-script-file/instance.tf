resource "aws_key_pair" "terraform_key" {
    key_name = "terraform_key"
    public_key = file("${var.PATH_TO_PUBLIC_KEY}")
}

// provisioning software on instance using script file (demo-2)

resource "aws_instance" "demo_terraform-01" {

    instance_type = "t2.micro"
    ami = "${var.AMIS["${var.AWS_REGION}"]}"
    key_name = aws_key_pair.terraform_key.key_name

    provisioner "file" {
        source = "script.sh"
        destination = "/tmp/script.sh"
    }

    provisioner "remote-exec" {
        inline = [
            "chmod +x /tmp/script.sh",
            "sudo sed -i -e 's/\r$//' /tmp/script.sh",
            "sudo /tmp/script.sh",
        ]
    }

    connection {
        host = coalesce(self.public_ip, self.private_ip)
        type = "ssh"
        user = "${var.INSTANCE_USERNAME}"
        private_key = file("${var.PATH_TO_PRIVATE_KEY}")
  }

}
