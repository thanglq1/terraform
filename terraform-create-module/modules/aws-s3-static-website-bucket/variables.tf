variable "bucket_name" {
  description = "Name of S3 bucket must be unique."
  type        = string
}

variable "tags" {
  description = "Tags to set on the bucket."
  type        = map(string)
  default     = {}
}

variable "index_name" {
  description = "Index file name of website. e.g: index.html"
  type        = string
}

variable "error_name" {
  description = "Error file name of website. e.g: error.html"
  type        = string
}
