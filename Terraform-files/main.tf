resource "aws_instance" "deploy-server" {
  ami = "ami-0e86e20dae9224db8"
  instance_type = "t2.micro"
  key_name = "mykey"
  vpc_security_group_ids = ["sg-02c7dbd4907391ff7"]
  connection {
     type = "ssh"
     user = "ubuntu"
     private_key = file("./mykey.pem")
     host = self.public_ip
     }
  provisioner "remote-exec" {
     inline = ["echo 'wait to start the instance' "]
  }
  tags = {
     Name = "deploy-server"
     }
  provisioner "local-exec" {
     command = "echo ${aws_instance.deploy-server.public_ip} > inventory"
     }
  provisioner "local-exec" {
     command = "ansible-playbook /var/lib/jenkins/workspace/banking-finance-prj/Terraform-files/ansibleplaybook.yml"
     }
  }
