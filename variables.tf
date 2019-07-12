variable "service_name" {
  description = "tagged with service name"
}
variable "aws_profile" {
  description = "aws profile name"
}
variable "lambda_function_name" {
  default = "lambda_function"
}
variable "lambda_handler_name" {
  default = "lambda_handler"
}
variable "whitelist_ip" {
  type = list(string)
}
variable "basic_auth_username" {}
variable "basic_auth_password" {}
