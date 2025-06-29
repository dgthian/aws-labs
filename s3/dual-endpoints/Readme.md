## Create a bucket
```sh
aws s3 mb s3://endpoint-dgt-27062025
````

## Upload a file to s3 using standard endpoint
```sh
touch standard.txt
aws s3 cp standard.txt s3://endpoint-dgt-27062025 --endpoint-url https://s3.eu-west-1.amazonaws.com
````

## Upload a file to s3 using dualstack endpoint
```sh
touch dualstack.txt
aws s3 cp dualstack.txt s3://endpoint-dgt-27062025 --endpoint-url https://s3.dualstack.eu-west-1.amazonaws.com
```

## Cleanup
aws s3 rm s3://endpoint-dgt-27062025/standard.txt
aws s3 rm s3://endpoint-dgt-27062025/dualstask.txt
aws s3 rb s3://endpoint-dgt-27062025