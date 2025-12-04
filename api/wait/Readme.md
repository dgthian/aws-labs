## Create an EC2 instance
INSTANCE_ID=$(aws ec2 run-instances \
    --image-id ami-08b6a2983df6e9e25 \
    --instance-type "t2.micro" \
    --query 'Instances[0].InstanceId' \
    --output text)
echo "Created instance with ID: $INSTANCE_ID"

## To watch for EC2 instance to be ready

```sh
aws ec2 wait instance-status-ok --instance-ids $INSTANCE_ID
```