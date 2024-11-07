Terraform Backend Setup
This project sets up a backend for Terraform using AWS. The configuration includes creating an S3 bucket to store Terraform state, a DynamoDB table to manage state locks, and an IAM user with administrator permissions to deploy the infrastructure.

What does the Code do?
Terraform Backend: Configure Terraform to use an S3 bucket to store state and a DynamoDB table to handle crashes.

AWS Provider: Defines the AWS Region in which the resources will be deployed.

DynamoDB Table: Creates a DynamoDB table called tfstatelocks that is used to manage Terraform state locks.

S3 bucket: Creates an S3 bucket to store the state of Terraform.

IAM User: Creates an IAM user named terraform_deployer and attaches the AdministratorAccess policy to it.

How to use the code?
Prerequisites
Have an AWS account
Have terraform installed
Steps to Use
1- Clone the Repository: Clone this repository on your local machine.

'''JavaScript git clone <url-del-repositorio> CD <nombre-del-repositorio>

2- **Configure AWS Variables:** Have your AWS credentials configured. You can do this by configuring your environment variables or by using the AWS credentials file.

'''JavaScript
export AWS_ACCESS_KEY_ID=<tu-access-key-id>
export AWS_SECRET_ACCESS_KEY=<tu-secret-access-key>
3- Initialize Terraform: Go to the project folder and run the terraform init command to initialize the project. This will download the necessary plugins and set up the backend.

'''JavaScript Terraform Init

4- Apply Settings:** Run the terraform apply command to create the resources. Review the execution plan and confirm to apply the changes.

'''JavaScript
Terraform Apply
Code
Terraform Backend

terraform {
  Backend "S3" {
    bucket = "your-unique-bucket-name"
    key = "path/to/terraform.tfstate"
    region="us-east-1" #Virginia
    dynamodb_table = "tfstatelocks"
    encrypt = true
  }
}
bucket: Name of the S3 bucket where the Terraform state will be stored.

key: Path within the S3 bucket to store the state file.

Region: The AWS Region where the bucket is located.

dynamodb_table: Name of the DynamoDB table for locks.

encrypt: Enables state file encryption.

Dynamodb table.

resource "aws_dynamodb_table" "terraform_locks" {
  name = "tfstatelocks"
  billing_mode = "PAY_PER_REQUEST"
  hash_key = "LockID"

attribute {
    name = "LockID"
    type = "S"
  }

tags = {
    Name = "terraform-locks-table"
    Environment = "dev"
  }
}
- name: Name of the DynamoDB table. - billing_mode: Billing mode per request. - hash_key: Hash key for the table. - attribute: Defines the attributes of the table. - tags: Tags for the DynamoDB table.
Bucket S3

''''resource "aws_s3_bucket" "terraform_state" { bucket = "my-terraform-state-bucket" tags = { Name = "terraform-state-bucket" Environment = "dev" } }

- bucket: Name of the S3 bucket.
- tags: Tags for the S3 bucket.

**IAM User**
resource "aws_iam_user" "terraform_deployer" { name = "terraform_deployer" }

- name: Name of the IAM user.


**IAM User Policy**
resource "aws_iam_user_policy_attachment" "admin_policy_attachment" { user = aws_iam_user.terraform_deployer.name policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess" } ```` - user: Name of the IAM user to whom the policy is attached. - policy_arn: ARN for the AWS AdministratorAccess policy.