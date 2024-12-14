resource "aws_iam_role_policy_attachment" "tf_rds_policy" {
  role       = aws_iam_role.tf_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonRDSFullAccess"
}
