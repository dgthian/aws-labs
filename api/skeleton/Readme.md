## Generate our skeleton for EC2
aws ec2 run-instances \
    --image-id ami-09c54d172e7aa3d9a \
    --instance-type t2.micro \
    --generate-cli-skeleton > sekelton.json
 
 # Convert JSON to YAML
yq -oy -p=json ./sekelton.json > skeleton.yaml

# Load Yaml Input file
aws ec2 run-instances --cli-input-yaml file://skeleton.yaml --region eu-west-1
