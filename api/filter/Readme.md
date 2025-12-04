# Get a bounch of subnets

aws ec2 describe-subnets \
  --region eu-west-1 \
  --query "Subnets[].AvailabilityZone"


aws ec2 describe-subnets \
  --region eu-west-1 \
  --filters "Name=availability-zone,Values=eu-west-1a" \
  --query "Subnets[].AvailabilityZone"


