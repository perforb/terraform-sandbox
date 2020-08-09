data "aws_iam_policy_document" "alb_log" {
  statement {
    effect    = "Allow"
    actions   = ["s3:PutObject"]
    resources = ["arn:aws:s3:::${module.datasource.alb_log_bucket_id}/*"]

    principals {
      type        = "AWS"
      identifiers = [var.alb_logger.ap-northeast-1]
    }
  }
}

resource "aws_s3_bucket_policy" "alb_log" {
  bucket = module.datasource.alb_log_bucket_id
  policy = data.aws_iam_policy_document.alb_log.json
}