
provider "aws" {
  region = "us-east-1"
}

resource "aws_iam_role" "layer_role" {
  name = "layer_role"
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

resource "aws_lambda_layer_version" "lambda_layer" {
  layer_name = "layer"
  filename = "layer.zip"
  compatible_runtimes = ["python3.9"]
  compatible_architectures = ["x86_64"]
}

resource "aws_lambda_function" "lambda_with_layer" {
  function_name = "lambda_with_layer"
  handler = "handler.lambda_handler"
  runtime = "python3.9"
  architectures = ["x86_64"]
  role = aws_iam_role.layer_role.arn
  filename = "code.zip"
  layers = [aws_lambda_layer_version.lambda_layer.arn]
}