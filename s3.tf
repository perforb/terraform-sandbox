resource "aws_s3_bucket" "private" {
  bucket        = "private-perforb-terraform"
  force_destroy = true # オブジェクトが残っていても強制削除

  versioning {
    enabled = true
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

resource "aws_s3_bucket_public_access_block" "private" {
  bucket                  = aws_s3_bucket.private.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket" "public" {
  bucket        = "public-perforb-terraform"
  acl           = "public-read"
  force_destroy = true # オブジェクトが残っていても強制削除

  cors_rule {
    allowed_origins = ["https://example.com"]
    allowed_methods = ["GET"]
    allowed_headers = ["*"]
    max_age_seconds = 3000
  }
}

resource "aws_s3_bucket" "alb_log" {
  bucket        = "alb-log-perforb-terraform"
  force_destroy = true # オブジェクトが残っていても強制削除

  lifecycle_rule {
    enabled = true

    expiration {
      days = "180"
    }
  }
}

resource "aws_s3_bucket_policy" "alb_log" {
  bucket = aws_s3_bucket.alb_log.id
  policy = data.aws_iam_policy_document.alb_log.json
}

resource "aws_s3_bucket" "artifact" {
  bucket        = "artifact-perforb-terraform"
  force_destroy = true # オブジェクトが残っていても強制削除

  lifecycle_rule {
    enabled = true

    expiration {
      days = "180"
    }
  }
}

resource "aws_s3_bucket" "operation" {
  bucket        = "operation-perforb-terraform"
  force_destroy = true # オブジェクトが残っていても強制削除

  lifecycle_rule {
    enabled = true

    expiration {
      days = "180"
    }
  }
}

resource "aws_s3_bucket" "athena" {
  bucket        = "athena-perforb-terraform"
  force_destroy = true # オブジェクトが残っていても強制削除

  lifecycle_rule {
    enabled = true

    expiration {
      days = "180"
    }
  }
}

resource "aws_s3_bucket" "cloudwatch_logs" {
  bucket        = "cloudwatch-logs-perforb-terraform"
  force_destroy = true # オブジェクトが残っていても強制削除

  lifecycle_rule {
    enabled = true

    expiration {
      days = "180"
    }
  }
}