provider "aws" {
  region = "ap-southeast-1"
}

resource "aws_instance" "hello0" {
  ami           = "ami-05caa5aa0186b660f"
  instance_type = "t2.micro"
  user_data     = templatefile("hello.tpl", { output = "hello0" })

  tags = {
    Name = "hello0"
  }
}

resource "aws_instance" "hello1" {
  ami           = "ami-05caa5aa0186b660f"
  instance_type = "t2.micro"
  user_data     = templatefile("hello.tpl", { output = "hello1" })

  tags = {
    Name = "hello1"
  }
}

resource "aws_instance" "gateway" {
  ami           = "ami-05caa5aa0186b660f"
  instance_type = "t2.micro"
  user_data = templatefile("nginx.tpl", {
    hello0_ip = "${aws_instance.hello0.private_ip}"
    hello1_ip = "${aws_instance.hello1.private_ip}"
  })

  tags = {
    Name = "gateway"
  }
}
