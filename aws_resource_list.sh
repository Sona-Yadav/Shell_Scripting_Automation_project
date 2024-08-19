#!/bin/bash

#######################################################################################################
# Description:  The script will prompt the user to enter the AWS region and the service for which the resources need to be listed.
# Author : Sona 
# Version: v0.0.1
# Usage: ./aws_resource_list.sh <region> <service_name>
# Example: ./aws_resource_list.sh us-east-1 EC2

# Following are the supported AWS services by the script: 
# 1. EC2
# 2. S3
# 3. RDS
# 4. DyanamoDB
# 5. Lambda
# 6. EBS
# 7. VPC
# 8. SNS
# 9. SQS
# 10. IAM
# 11. CloudWatch
# 12. CloudFormation
# 13. CloudFront
# 14. Route53
# 15. ElasticBeanstalk

#########################################################################################################

# Check if the rquired numbers of arguments are passed
if [$# -ne 2]; then
    echo "Usage : $0 <region> <service_name>"
    exit 1
fi

# Assign the arguments to variables and convert the service to lowercase
aws_region=$1
aws_service=$2

# Check if AWS CLI is installed 
if ! command -v aws &> /dev/null; then
    echo "AWS CLI is not installed. Please install the AWS CLI and try again."
    exit 1
fi

# Check if the AWS CLI is configured
if [ ! -d ~/.aws ]; then
    echo "AWS CLI is not configured. Please configure the AWS CLI and try again."
    exit 1
fi

# List the resources based on the service
case $aws_service in
    ec2)
        echo "Listing EC2 Instances in $aws_region"
        aws ec2 describe-instances --region $aws_region
        ;;
    rds)
        echo "Listing RDS Instances in $aws_region"
        aws rds describe-db-instances --region $aws_region
        ;;
    s3)
        echo "Listing S3 Buckets in $aws_region"
        aws s3api list-buckets --region $aws_region
        ;;
    cloudfront)
        echo "Listing CloudFront Distributions in $aws_region"
        aws cloudfront list-distributions --region $aws_region
        ;;
    vpc)
        echo "Listing VPCs in $aws_region"
        aws ec2 describe-vpcs --region $aws_region
        ;;
    iam)
        echo "Listing IAM Users in $aws_region"
        aws iam list-users --region $aws_region
        ;;
    route5)
        echo "Listing Route53 Hosted Zones in $aws_region"
        aws route53 list-hosted-zones --region $aws_region
        ;;
    cloudwatch)
        echo "Listing CloudWatch Alarms in $aws_region"
        aws cloudwatch describe-alarms --region $aws_region
        ;;
    cloudformation)
        echo "Listing CloudFormation Stacks in $aws_region"
        aws cloudformation describe-stacks --region $aws_region
        ;;
    lambda)
        echo "Listing Lambda Functions in $aws_region"
        aws lambda list-functions --region $aws_region
        ;;
    sns)
        echo "Listing SNS Topics in $aws_region"
        aws sns list-topics --region $aws_region
        ;;
    sqs)
        echo "Listing SQS Queues in $aws_region"
        aws sqs list-queues --region $aws_region
        ;;
    dynamodb)
        echo "Listing DynamoDB Tables in $aws_region"
        aws dynamodb list-tables --region $aws_region
        ;;
    ebs)
        echo "Listing EBS Volumes in $aws_region"
        aws ec2 describe-volumes --region $aws_region
        ;;
    *)
        echo "Invalid service. Please enter a valid service."
        exit 1
        ;;
esac