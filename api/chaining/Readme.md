# Chaining with Env Vars

```sh
export VPC_ID=$(
aws ec2 describe-vpcs \
--region eu-west-1 \
--filters "Name=isDefault,Values=true" \
--query "Vpcs[0].VpcId" \
--output text
)
```

```sh
export CIDR_BLOCK=$(aws ec2 describe-vpcs \
--region eu-west-1 \
--filters "Name=isDefault,Values=true" \
--query "Vpcs[0].CidrBlock" \
--output text | sed 's/0.0\/16/96.0\/24/')

```

```sh
echo $VPC_ID
echo $CIDR_BLOCK
```

```sh
aws ec2 create-subnet \
--vpc-id $VPC_ID \
--cidr-block $CIDR_BLOCK \
--tag-specifications 'ResourceType=subnet,Tags=[{Key=Name,Value=my-ipv4-only-subnet}]'
```

## Chaining with XArgs

```sh
aws ec2 describe-vpcs \
--region eu-west-1 \
--query "Vpcs[0].VpcId" \
--filters "Name=is-default,Values=true" \
--output text | xargs -I {} aws ec2 describe-subnets \
--region eu-west-1 \
--filters "Name=vpc-id,Values={}" \
--query "Subnets[*].[SubnetId,CidrBlock]" \
--output table
```
