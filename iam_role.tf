data "aws_iam_policy_document" "lambda_edge_assume_role" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com", "edgelambda.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "lambda_edge_inline_policy" {
  statement {
    effect = "Allow"

    actions = [
      "lambda:GetFunction",
      "lambda:EnableReplication*",
      "iam:CreateServiceLinkedRole",
      "cloudfront:UpdateDistribution",
      "cloudfront:CreateDistribution",
    ]

    resources = ["*"]
  }
}

resource "aws_iam_role" "cloudfront_lambda_associations" {
  name = "CloudFlontLambdaAssociations"
  assume_role_policy = data.aws_iam_policy_document.lambda_edge_assume_role.json
}

resource "aws_iam_role_policy" "cloudfront_lambda_inline_policy" {
  name = "CloudFlontLambdaAssociationsPolicy"
  role = aws_iam_role.cloudfront_lambda_associations.id
  policy = data.aws_iam_policy_document.lambda_edge_inline_policy.json
}

resource "aws_iam_role_policy_attachment" "lambda_execution" {
  role       = aws_iam_role.cloudfront_lambda_associations.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}
