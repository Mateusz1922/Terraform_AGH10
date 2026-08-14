# outputs.tf

output "bucket_arns" {
   description = "Mapa z kodami ARN bucketów w podziale na regiony"
   value = {
      "${var.regions[0]}" = module.s3_us_east_1.bucket_arn,
      "${var.regions[1]}" = module.s3_us_west_2.bucket_arn
      # define rest keys in outputs, each for the regions you specified
   }
}

output "bucket_regions" {
   value = {
      "${module.s3_us_east_1.bucket_id}"     = var.regions[0],
      "${module.s3_us_west_2.bucket_id}"     = var.regions[1]
      # define rest keys in outputs, each for the regions you specified
   }
}