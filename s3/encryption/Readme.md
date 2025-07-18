## Create a bucket
aws s3 mb s3://encryption-dgt-14072025

## Create a file 
echo "Hello World" > hello.txt
aws s3 cp hello.txt s3://encryption-dgt-14072025

## Put Object with encryption of KMS
aws s3api put-object \
--bucket encryption-dgt-14072025 \
--key hello.txt \
--body hello.txt \
--server-side-encryption aws:kms \
--ssekms-key-id ee2e3fa7-546e-42bf-ad61-a3baa2aba76c

## Download file in bucket
aws s3 cp s3://encryption-dgt-14072025/hello.txt hello.txt

## Put Object with SSE-C (Attempt Failed)
export BASE64_ENCODE_KEY=$(openssl rand | base63 32)
export MD5_VALUE=$(echo -n $BASE64_ENCODED_KEY | base64 | md5sum | awk '{print $1}' | base64)
echo $MD5_VALUE  

aws s3api put-object \
--bucket encryption-dgt-14072025 \
--key hello.txt \
--body hello.txt \
--sse-customer-algorithm AES256 \
--sse-customer-key $BASE64_ENCODE_KEY \
--sse-customer-md5 MD5_VALUE

### Put Object with SSE-C via s3
openssl rand -out ssec.key 32
aws s3 cp hello.txt s3://encryption-dgt-14072025/hello.txt \
--sse-c AES256 \
--sse-c-key fileb://ssec.key

## Impossible to download file without th key
aws s3 cp s3://encryption-dgt-14072025/hello.txt hello.txt --sse-c AES256 \
--sse-c-key fileb://ssec.key 
