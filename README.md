# terraform-aws-lambda-edge-basic-auth

## Usage

```hcl
module "lambda_edge_basic_auth" {
  source = "realglobe-Inc/lambda-edge-basic-auth/aws"
  service_name = "your-service-name"
  aws_profile = "aws-profile-name"
  whitelist_ip = ["127.0.0.1"]
  basic_auth_username = "username"
  basic_auth_password = "password"
  lambda_function_name = "lambda_function"  # optional
  lambda_handler_name = "lambda_handler"  # optional
}
```

Use Lambda@Edge in CloudFront.

```hcl
resource "aws_cloudfront_distribution" "web" {
  ...

  default_cache_behavior {
    ...

    lambda_function_association {
      event_type = "viewer-request"
      lambda_arn = module.lambda_edge_basic_auth.lambda_qualified_arn
    }
  }
}
```
