locals {
  lambda_zip_location = "outputs/lambda.zip"
}

data "archive_file" "lambda" {
  type        = "zip"
  source_file = "lambda.py"
  output_path = "${local.lambda_zip_location}"
}

resource "aws_lambda_function" "test_lambda" {
  filename      = local.lambda_zip_location
  function_name = "lambda_using_terraform"
  role          = aws_iam_role.lambda_role.arn
  handler       = "lambda.hello"

  runtime = "python3.8"
}
