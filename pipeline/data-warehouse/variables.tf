variable "bucket_name" {
  type        = string
  description = "This variable represents the name of your bucket"
  default = ""
}

variable "bucket_location" {
  type        = string
  default     = "us-east1"
  description = "This variable indicates the location of the bucket. If not specified, the default location is set to `us-east1`"
}

variable "project_id" {
  type        = string
  description = "This variable holds the unique identifier of the project associated with the bucket"
  default = " "
}

variable "storage_class" {
  type        = string
  description = "This variable denotes the storage class of the bucket, indicating the performance and cost characteristics of the storage"
  default = " "
}