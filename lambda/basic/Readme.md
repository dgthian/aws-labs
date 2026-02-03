## Zipper la Lambda
```sh
zip function.zip lambda_function.py
```

## Upload sur S3
```sh
aws s3 cp function.zip s3://my-lambda-artifacts-bucket/function.zip --endpoint-url=http://localhost.localstack.cloud:4566
```

## Déployer la stack
```sh
aws cloudformation deploy \
  --endpoint-url=http://localhost.localstack.cloud:4566 \
  --template-file template.yaml \
  --stack-name my-python-lambda-stack \
  --capabilities CAPABILITY_NAMED_IAM
```

## Tester la Lambda
```sh
aws lambda invoke \
  --endpoint-url=http://localhost.localstack.cloud:4566 \
  --function-name my-python-lambda \
  response.json
```