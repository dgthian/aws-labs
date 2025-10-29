## Install localStack CLI

```sh
brew install localstack/tap/localstack-cli
```

## Create moc S3 bucket	
```sh
aws --endpoint-url=http://localhost:4566 s3 mb s3://my-bucket
```

## List buckets	
```sh
aws --endpoint-url=http://localhost:4566 s3 ls
```

## Set an Env Var endpoint just for s3
export AWS_ENDPOINT_URL=http://localhost:4566

## Lis env Vars
```sh
env | grep AWS_ENDPOINT
````
