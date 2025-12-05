// to create a resource
resource "aws_instance" "instance" {
  for_each      = var.components
  ami           = var.ami
  instance_type = var.instance_type
  iam_instance_profile = aws_iam_instance_profile.instance_profile.name

}
resource "null_resource" "provisioner" {
  for_each = var.components
  provisioner "remote-exec" {
    connection {
      type     = "ssh"
      user     = "ec2-user"
      password = "DevOps321"
      host     = aws_instance.instance[each.key].private_ip
    }
    inline = [
      "sudo dnf install python3.11-pip -y",
      "sudo pip3.11 install ansible"
    ]
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
