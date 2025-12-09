brew install yq

aws ec2 describe-vpcs | yq .

aws ec2 describe-vpcs | yq . -pjson ## transform response to JSON

aws ec2 describe-vpcs | yq . -pjson -oxml ## Outpout XML

aws ec2 describe-vpcs | yq . -pjson -oy ## Outpout YAML

aws ec2 describe-vpcs | yq ".Vpcs[].CidrBlock" -pjson -oy


## Recommendation use jq for most use case and use yq when we work with yaml


