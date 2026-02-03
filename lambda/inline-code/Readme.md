## Déployer sur LocalStack

```sh
aws --endpoint-url=http://localhost:4566 cloudformation deploy \
  --template-file template.yaml \
  --stack-name inline-lambda-stack \
  --capabilities CAPABILITY_NAMED_IAM
```

## Tester la Lambda
```sh
aws --endpoint-url=http://localhost:4566 lambda invoke \
  --function-name inline-python-lambda \
  response.json
```

## Résultat attendu :
```sh
cat response.json
```

