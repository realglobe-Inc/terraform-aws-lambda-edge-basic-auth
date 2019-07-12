# Lambda@Edgeはus-east-1で作成する必要がある
provider "aws" {
  alias = "us-east-1"
  region = "us-east-1"
  profile = var.aws_profile
}

resource "aws_lambda_function" "basic_auth" {
  provider = "aws.us-east-1"
  filename = data.archive_file.lambda_function.output_path
  function_name = "${var.service_name}-basic_auth"
  description = "IP filtering and basic auth for ${var.service_name}"
  handler = "${var.lambda_function_name}.${var.lambda_handler_name}"
  role = aws_iam_role.cloudfront_lambda_associations.arn
  runtime = "nodejs10.x"
  publish = true
  source_code_hash = data.archive_file.lambda_function.output_base64sha256
}
