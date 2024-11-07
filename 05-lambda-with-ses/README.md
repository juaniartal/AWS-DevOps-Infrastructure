# Lambda: Send Daily Email

This project sets up an AWS Lambda function that sends a daily email using **Amazon SES**. The Lambda is scheduled to trigger every two minutes using **CloudWatch Events** and is used to send a monitor request. The email body and recipient are managed via environment variables.

## Description

The Lambda function is written in **Python 3.8** and uses the `boto3` library to interact with AWS services such as SES (to send emails) and CloudWatch Logs (to log executions). The Lambda code is packaged into a ZIP file and uploaded to AWS for execution.

### Project Components

1. **AWS Lambda Function**: The main function that sends the email.
2. **Amazon SES**: Used to send the email.
3. **CloudWatch Logs**: Logs the Lambda executions.
4. **CloudWatch Event Rule**: Used to trigger the Lambda at a specified schedule (every two minutes in this case).
5. **IAM Role**: IAM roles that provide the necessary permissions for the Lambda.

### Requirements

- **AWS Account**: To create the necessary resources in AWS.
- **Environment Variables**:
    - `EMAIL_SUBJECT`: Subject of the email.
    - `EMAIL_BODY`: Body of the email.
    - `EMAIL_TO`: The recipient email address.
    - `EMAIL_FROM`: The sender email address (must be verified in SES).

### AWS Resources Configured

1. **Lambda Function**: The function is triggered by CloudWatch Events and executes the Python code to send an email.
2. **SES Email Identity**: The `EMAIL_FROM` and `EMAIL_TO` addresses must be verified in Amazon SES to send and receive emails.
3. **CloudWatch Log Group**: Logs the Lambda function's output for monitoring and debugging purposes.
4. **CloudWatch Event Rule**: A rule that triggers the Lambda function at a defined schedule (every 2 minutes).
5. **IAM Role & Policies**: The Lambda requires specific permissions to interact with SES and CloudWatch Logs.

### Terraform Configuration

- **Lambda Function**: The function is packaged from the `lambda` directory and uploaded to AWS.
- **IAM Role**: The Lambda execution role is granted permissions to interact with SES and CloudWatch.
- **CloudWatch Event**: A schedule is set to trigger the Lambda function every two minutes.
- **SES Email Identity**: Both sender and receiver email addresses are configured as SES identities.

### Usage

To deploy this Lambda function using Terraform:

1. Clone the repository to your local machine.
2. Ensure you have Terraform installed and configured to use your AWS account.
3. Run `terraform init` to initialize the Terraform configuration.
4. Run `terraform apply` to create the Lambda function and related AWS resources.
5. Check CloudWatch Logs to monitor the Lambda function's executions and SES to verify email sending.

### Note

- The Lambda function is triggered every two minutes by the CloudWatch Event Rule.
- You need to verify the email addresses (sender and receiver) in **Amazon SES** before using them for sending and receiving emails.

---

For more details, refer to the [AWS Lambda documentation](https://docs.aws.amazon.com/lambda/latest/dg/welcome.html) and the [Amazon SES documentation](https://docs.aws.amazon.com/ses/latest/dg/Welcome.html).





