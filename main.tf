// to create a resource
resource "aws_instance" "instance" {
  for_each      = var.components
  ami           = var.ami
  instance_type = var.instance_type
  iam_instance_profile = aws_iam_instance_profile.instance_profile.name
  connection {
    type     = "ssh"
    user     = "ec2-user"
    password = "DevOps321"
    host     = self.public_ip
  }
  provisioner "remote-exec" {
    inline = [
        "sudo dnf install python3.11-pip -y",
        "sudo pip3.11 install ansible "
    ]
  }
  tags = {
    Name = each.key
 }
}

# create a dns record
resource "aws_route53_record" "record" {
  for_each         =    var.components
  zone_id          =    var.zone_id
  name             =    each.key
  type             =    "A"
  ttl              =     5
  records          =   [aws_instance.instance[each.key].private_ip]
}


# RHEL-9-DevOps-Practice
