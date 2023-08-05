## How to use

1. cd to terraform-create-module
2. Run command `terraform init`
3. Run command `terraform apply`
4. Upload index.html and error.html files in /modules/www to S3 bucket just created (In this demo bucket name is "thang-test-05-08-2023")
5. Open browser and go to your website something like this http://thang-test-05-08-2023.s3-website-ap-southeast-2.amazonaws.com/
