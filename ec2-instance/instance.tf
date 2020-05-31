resource "aws_instance" "example" {
  ami           = "${lookup(var.AMIS, var.AWS_REGION)}"
  instance_type = "t2.micro"
}

output "ip" {
    value = "${aws_instance.example.public_ip}"
}