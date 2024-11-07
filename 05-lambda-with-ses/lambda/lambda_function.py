import boto3
import os

def lambda_handler(event, context):
    ses = boto3.client('ses')

    response = ses.send_email(
        Source=os.environ['EMAIL_FROM'],
        Destination={
            'ToAddresses': [os.environ['EMAIL_TO']],
        },
        Message={
            'Subject': {
                'Data': os.environ['EMAIL_SUBJECT'],
            },
            'Body': {
                'Text': {
                    'Data': os.environ['EMAIL_BODY'],
                }
            }
        }
    )

    print(f"Email sent! Message ID: {response['MessageId']}")