# variables.tf

variable "region" {
  type    = string
  description = "Region AWS, w których zostaną utworzone buckety S3"
  default     = "us-east-1"
}

variable "bucket_name_prefix" {
  type    = string
  description = "Unikalny przedrostek dla nazw bucketów S3"
  default     = "mateusz-tf-demo"
}

variable "random_suffix" {
  type    = string
  description = "Losowa końcówka (doklejana na końcu nazwy bucketa) zapewniająca unikalność w skali całego AWS."
}

variable "lifecycle_days" {
  type        = number
  description = "Liczba dni, po których obiekty w S3 przejdą do nowej klasy magazynowej w ramach reguły lifecycle."
  default     = 90
}

variable "lifecycle_storage_class" {
  type        = string
  description = "Docelowa klasa magazynowa S3 (np. GLACIER, GLACIER_IR, STANDARD_IA), do której mają trafiać obiekty po upływie zdefiniowanych dni."
  default     = "GLACIER"
}