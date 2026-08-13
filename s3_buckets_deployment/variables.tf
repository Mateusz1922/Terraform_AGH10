# variables.tf

variable "regions" {
  type    = list(string)
  description = "Lista regionów AWS, w których zostaną utworzone buckety S3"
  default     = ["us-east-1", "us-west-2"]
}

variable "bucket_name_prefix" {
  type    = string
  description = "Unikalny przedrostek dla nazw bucketów S3"
  default     = "mateusz-tf-demo"
}