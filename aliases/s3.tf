# s3.tf

# uses default provider configuration
resource "aws_s3_bucket" "my_bucket" {
  bucket = "repo-agh-mlops-bucket-21376769" # replace with your own unique name
  tags = {
    Name = "my-bucket"
  }
}

# alias provider specified, it will use its configuration
resource "aws_s3_bucket" "my_bucket_eu_west_3" {
  bucket   = "repo-agh-mlops-bucket-2137676996767312" # replace with your own unique name
  provider = aws.eu_west_3
  tags = {
    Name = "my-bucket"
  }
}