#!/bin/bash

echo "🔍 Checking AWS EC2 resources..."

# Get all regions
regions=$(aws ec2 describe-regions --query "Regions[].RegionName" --output text)

for region in $regions
do
    echo ""
    echo "📍 Region: $region"

    # Check running instances
    instances=$(aws ec2 describe-instances \
        --region $region \
        --query "Reservations[].Instances[?State.Name=='running'].InstanceId" \
        --output text)

    if [ -z "$instances" ]; then
        echo "✅ No running instances"
    else
        echo "🚨 Running instances:"
        echo "$instances"
    fi
done

echo "active lambda functions...."
for region in $regions
do 
    echo ""
    functions=$(aws lambda list-functions --region $region --query "Functions[?State=='Active'].FunctionName" --output text)
    if [ -z "$functions" ]; then
        echo "✅ No active lambda functions"
    else
        echo "🚨 Active lambda functions:"

    fi
done
    
echo "active s3 buckets...."
for region in $regions
do
    echo ""
    buckets=$(aws s3api list-buckets --query "Buckets[].Name" --output text)
    if [ -z "$buckets" ]; then
        echo "✅ No active s3 buckets"
    else
        echo "🚨 Active s3 buckets:"
        echo "$buckets"
    fi
done

echo "active RDS instances...."
for region in $regions
do
    echo ""
    instances=$(aws rds describe-db-instances --region $region --query "DBInstances[?DBInstanceStatus=='available'].DBInstanceIdentifier" --output text)
    if [ -z "$instances" ]; then
        echo "✅ No active RDS instances"
    else
        echo "🚨 Active RDS instances:"
        echo "$instances"
    fi
done

echo "active IAM users...."
for region in $regions
do
    echo ""
    users=$(aws iam list-users --region $region --query "Users[?Path=='/'].UserName" --output text)
    if [ -z "$users" ]; then
        echo "✅ No active IAM users"
    else
        echo "🚨 Active IAM users:"
        echo "$users"
    fi
done

echo "in-use ebs volumes...."
for region in $regions
do
    echo ""
    volumes=$(aws ec2 describe-volumes --region $region --query "Volumes[?State=='in-use'].VolumeId" --output text)
    if [ -z "$volumes" ]; then
        echo "✅ No in-use EBS volumes"
    else
        echo "🚨 In-use EBS volumes:"
        echo "$volumes"
    fi
done


echo "running rds database instances...."
for region in $regions
do
    echo ""
    instances=$(aws rds describe-db-instances --region $region --query "DBInstances[?DBInstanceStatus=='available'].DBInstanceIdentifier" --output text)
    if [ -z "$instances" ]; then
        echo "✅ No running RDS instances"
    else
        echo "🚨 Running RDS instances:"
        echo "$instances"
    fi
done

echo "✅ Scan complete"