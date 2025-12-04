## example qurying with JMESPATH

aws ec2 describe-vpcs --query "Vpcs[].[CidrBlock,VpcId]"

aws ec2 describe-vpcs \
  --query "Vpcs[].{VpcId:VpcId, CidrBlock:CidrBlock, Subnets:Subnets[].SubnetId}" \
  --output json
