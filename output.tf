output "lambda_qualified_arn" {
  description = "AWS Lambda ARN with version"
  value = aws_lambda_function.basic_auth.qualified_arn
}
