provider "aws" {
  region = "us-east-1"
}

resource "aws_iam_role" "role" {
  name = "example"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_lambda_function" "lambda_custom_package" {
  function_name = "lambda_custom_package"
  handler = "handler.lambda_handler"
  runtime = "python3.9"
  role = aws_iam_role.role.arn
  filename = "handler.zip"
}