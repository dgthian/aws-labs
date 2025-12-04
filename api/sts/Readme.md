## Create a user with no permissions

We need to create a new user with no permissions and generate out access keys

```sh
aws iam create-user --user-name sts-machine-user
aws iam create-access-key --user-name sts-machine-user --output table
```

Copy access key and secret here

```sh
aws configure
```

# aws sts get-caller-identity (To get caller identity)
The edit credentials file to change away from default profile
```sh
open ~/.aws/credentials
```

Test who you are
```sh
aws sts get-caller-identity --profile sts
 ```       

Make sure you don't have access to s3
```sh
aws s3 ls --profile sts
```

## Create a Role

We need to create a role that will access a new resource
```sh
chmod u+x bin/deploy
bin/deploy
```

## Use new user credentials and assume role

To attach a policy to an IAM user

```sh
aws iam put-user-policy \
--user-name sts-machine-user \
--policy-name StsAssumePolicy \
--policy-document file://policy.json
```

```sh
aws sts assume-role \
--role-arn arn:aws:iam::816069170623:role/new-stack-20102025-RootRole-8NlacGWucssa \
--role-session-name s3-sts-20102025 \
--profile sts
```

```sh
aws sts get-caller-identity --profile assumed
```

```sh
aws s3 ls --profile assumed
```

## Cleanup
tear down your cloudformation stack via the AWS Management Console

```sh
aws iam delete-user-policy --user-name sts-machine-user --policy-name StsAssumePolicy
aws iam delete-access-key --access-key-id AKIA34AMDKW7YN3D3MWG --user-name sts-machine-user
aws iam delete-user --user-name sts-machine-user

```
