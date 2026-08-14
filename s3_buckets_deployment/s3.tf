# s3.tf

# Generowanie unikalnego ciągu dla każdego regionu na podstawie długości listy var.regions
resource "random_id" "bucket_suffix" {
  count       = length(var.regions) # notice new option - it will create N resources that can be accesses by [index]
  keepers     = {
    # suffix regenerates only when bucket_name_prefix changes, not on every apply
    bucket_name_prefix = var.bucket_name_prefix
  }
  byte_length = 6 # specify how many bytes you want
}

# create us-east-1 bucket using the default provider
module "s3_us_east_1" {
  source = "./modules/s3_bucket"
  bucket_name_prefix = var.bucket_name_prefix
  region = var.regions[0]
  random_suffix = random_id.bucket_suffix[0].hex
}

# create us-west-2 bucket using us_east_1 provider
module "s3_us_west_2" {
  source = "./modules/s3_bucket"
  # notice how we pass provider alias to the module.
  providers = {
    aws = aws.us_west_2
  }
  bucket_name_prefix = var.bucket_name_prefix
  region            = var.regions[1]
  random_suffix     = random_id.bucket_suffix[1].hex
  lifecycle_days = 30 # we can modify the days value if we want  
}

# Previous version before s3 refactoring
# # ==========================================
# # 1. BUCKET S3: us-east-1 (domyślny provider)
# # ==========================================
# resource "aws_s3_bucket" "s3_us_east_1" {
#   # concatenating strings: "${variable}-${other_variable}rest_of_string"
#   # accessing different random_id formats: random_id.bucket_suffix[i].hex / int / ...
#   # create bucket name concatenating bucket_name_prefix, region, and suffix using random_id in hex format
#   bucket        = "${var.bucket_name_prefix}-${var.regions[0]}-${random_id.bucket_suffix[0].hex}"
#   force_destroy = true
# }

# resource "aws_s3_bucket_versioning" "s3_us_east_1" {
#   bucket = aws_s3_bucket.s3_us_east_1.id

#   versioning_configuration {
#     status = "Enabled"
#   }
# }

# resource "aws_s3_bucket_lifecycle_configuration" "s3_us_east_1" {
#   bucket = aws_s3_bucket.s3_us_east_1.id

#   rule {
#     id     = "transition-to-glacier"
#     status = "Enabled"

#     filter {}

#     transition {
#       days          = 90 # specify correct n days here
#       storage_class = "GLACIER_IR" # specify correct storage_class (https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_lifecycle_configuration)
#     }
#   }
# }


# # define rest of buckets and its configurations, each for the regions you specified, do not forget to pass valid provider to resource options as in aliases example.
# #...
# # ==========================================
# # 2. BUCKET S3: us-west-2 (alias: aws.us_west_2)
# # ==========================================
# resource "aws_s3_bucket" "s3_us_west_2" {
#   provider      = aws.us_west_2
#   bucket        = "${var.bucket_name_prefix}-${var.regions[1]}-${random_id.bucket_suffix[1].hex}"
#   force_destroy = true
# }

# resource "aws_s3_bucket_versioning" "s3_us_west_2" {
#   provider = aws.us_west_2
#   bucket   = aws_s3_bucket.s3_us_west_2.id

#   versioning_configuration {
#     status = "Enabled"
#   }
# }

# resource "aws_s3_bucket_lifecycle_configuration" "s3_us_west_2" {
#   provider = aws.us_west_2
#   bucket   = aws_s3_bucket.s3_us_west_2.id

#   rule {
#     id     = "transition-to-glacier"
#     status = "Enabled"

#     filter {}

#     transition {
#       days          = 90
#       storage_class = "GLACIER_IR"
#     }
#   }
# }