# to get trust policy
data "aws_iam_policy_document" "assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}
output "trust_policy" {
  value = aws_iam_role.role.arn
}

# attach permission policy to the custom created role
# ec2:RunInstances is used to launch ec2 server
data "aws_iam_policy_document" "policy" {
  statement {
    effect    = "Allow"
    actions   = ["ec2:RunInstances"]
    resources = ["*"]
  }
}
data "aws_ami" "ami" {
  most_recent      = true
  owners = []
  filter {
    name   = "name"
    values = ["RHEL-9-DevOps-Practice"]
  }
}


