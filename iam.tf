// create an iam role and attach trust policy
resource "aws_iam_role" "role" {
  name = var.role
  description = "test-role"
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
}
# call permission policy dynamically
resource "aws_iam_policy" "policy" {
  name        = var.policy
  description = "A test policy"
  policy      = data.aws_iam_policy_document.policy.json
}

# attach permission policy to the role
resource "aws_iam_role_policy_attachment" "policy-attach" {
  role       = aws_iam_role.role.name
  policy_arn = aws_iam_policy.policy.arn
}
resource "aws_iam_instance_profile" "instance_profile" {
  name = var.instance_profile
  role = aws_iam_role.role.name
}
