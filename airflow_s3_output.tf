resource "aws_s3_bucket" "airflow_output_bucket" {
  count  = var.create_instance_profile && var.create_s3_output_bucket ? 1 : 0
  bucket = var.s3_output_bucket_name
  acl    = "private"
}

resource "aws_iam_policy" "s3_airflow_output_policy" {
  count  = var.create_instance_profile && var.create_s3_output_bucket ? 1 : 0
  name   = "${local.name}_airflow_output_bucket_policy"
  policy = <<-EOT
{
    "Version": "2012-10-17",
    "Statement": [
        {
          "Sid":"1",
          "Effect":"Allow",
          "Action":["s3:GetObject", "s3:PutObject", "s3:ListObjects", "s3:ListObjectsV2", "s3:HeadObject"],
          "Resource":["arn:aws:s3:::${join("", aws_s3_bucket.airflow_output_bucket.*.bucket)}/*"]
        }
    ]
}
EOT
}

resource "aws_iam_role_policy_attachment" "s3_airflow_output_policy" {
  count      = var.create_instance_profile && var.create_s3_output_bucket ? 1 : 0
  role       = join("", aws_iam_role.this.*.id)
  policy_arn = join("", aws_iam_policy.s3_airflow_output_policy.*.arn)
}