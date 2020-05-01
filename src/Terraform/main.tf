provider "aws" {
  version = "~> 2.0"
  region  = "eu-west-1"
}

resource "aws_s3_bucket" "todo_frontend" {
  bucket = var.frontend_bucket_name
  acl    = "public-read"
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "PublicReadAccess",
      "Effect": "Allow",
      "Principal": "*",
      "Action": "s3:GetObject",
      "Resource": "arn:aws:s3:::${var.frontend_bucket_name}/*"
    }
  ]
}
EOF

  website {
    index_document = "index.html"
  }

  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["PUT", "POST"]
    allowed_origins = ["*"]
    expose_headers  = ["ETag"]
    max_age_seconds = 3000
  }
}