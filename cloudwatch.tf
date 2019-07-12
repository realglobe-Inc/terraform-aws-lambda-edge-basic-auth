# default region
resource "aws_cloudwatch_log_group" "lambda" {
  name = "/aws/lambda/us-east-1.${aws_lambda_function.basic_auth.function_name}"
  retention_in_days = 7
}

# us-east-1
resource "aws_cloudwatch_log_group" "lambda_us_east" {
  provider = "aws.us-east-1"
  name = "/aws/lambda/${aws_lambda_function.basic_auth.function_name}"
  retention_in_days = 7
}
