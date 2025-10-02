## Create two buckets
aws s3 mb s3://server-logs-source-02102025
aws s3 mb s3://server-logs-dest-02102025

## Create Logs folder for the destination folder
aws s3api put-object --bucket server-logs-dest-02102025 --key Logs/

## Configure server logging

## Turn on logging for the source bucket
aws s3api put-bucket-logging --bucket server-logs-source-02102025 --bucket-logging-status file://logging.json

## Allow sourec bucket to put data into bucket dest
aws s3api put-bucket-policy --bucket server-logs-dest-02102025 --policy file://policy.json 


## Source Data
echo "Hello World" > hello.txt
echo "Hello Mars" > hello_mars.txt
echo "Hello Moon" > hello_moon.txt


## Upload data to the source bucket
aws s3 cp hello.txt s3://server-logs-source-02102025/hello.txt
aws s3 cp hello_mars.txt s3://server-logs-source-02102025/hello_mars.txt
aws s3 cp hello_moon.txt s3://server-logs-source-02102025/hello_moon.txt

## Download access logs
aws s3 sync s3://server-logs-dest-02102025/Logs/ Logs/

## Query via Athena
# https://docs.aws.amazon.com/AmazonS3/latest/userguide/using-s3-access-logs-to-identify-requests.html

aws s3 mb s3://athena-results-02102025

```sql
CREATE DATABASE s3_access_logs_db
```

```sql
CREATE EXTERNAL TABLE s3_access_logs_db.mybucket_logs( 
 `bucketowner` STRING, 
 `bucket_name` STRING, 
 `requestdatetime` STRING, 
 `remoteip` STRING, 
 `requester` STRING, 
 `requestid` STRING, 
 `operation` STRING, 
 `key` STRING, 
 `request_uri` STRING, 
 `httpstatus` STRING, 
 `errorcode` STRING, 
 `bytessent` BIGINT, 
 `objectsize` BIGINT, 
 `totaltime` STRING, 
 `turnaroundtime` STRING, 
 `referrer` STRING, 
 `useragent` STRING, 
 `versionid` STRING, 
 `hostid` STRING, 
 `sigv` STRING, 
 `ciphersuite` STRING, 
 `authtype` STRING, 
 `endpoint` STRING, 
 `tlsversion` STRING,
 `accesspointarn` STRING,
 `aclrequired` STRING)
 PARTITIONED BY (
   `timestamp` string)
ROW FORMAT SERDE 
 'org.apache.hadoop.hive.serde2.RegexSerDe' 
WITH SERDEPROPERTIES ( 
 'input.regex'='([^ ]*) ([^ ]*) \\[(.*?)\\] ([^ ]*) ([^ ]*) ([^ ]*) ([^ ]*) ([^ ]*) (\"[^\"]*\"|-) (-|[0-9]*) ([^ ]*) ([^ ]*) ([^ ]*) ([^ ]*) ([^ ]*) ([^ ]*) (\"[^\"]*\"|-) ([^ ]*)(?: ([^ ]*) ([^ ]*) ([^ ]*) ([^ ]*) ([^ ]*) ([^ ]*) ([^ ]*) ([^ ]*))?.*$') 
STORED AS INPUTFORMAT 
 'org.apache.hadoop.mapred.TextInputFormat' 
OUTPUTFORMAT 
 'org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat'
LOCATION
 's3://server-logs-dest-02102025/Logs/816069170623/eu-west-1/server-logs-source-02102025/'
 TBLPROPERTIES (
  'projection.enabled'='true', 
  'projection.timestamp.format'='yyyy/MM/dd', 
  'projection.timestamp.interval'='1', 
  'projection.timestamp.interval.unit'='DAYS', 
  'projection.timestamp.range'='2024/01/01,NOW', 
  'projection.timestamp.type'='date', 
  'storage.location.template'='s3://server-logs-dest-02102025/Logs/816069170623/eu-west-1/server-logs-source-02102025/${timestamp}')
```

```sql
SELECT bucket_name, key, operation
FROM s3_access_logs_db.mybucket_logs 
WHERE requester='arn:aws:iam::816069170623:user/djibril';
```

## Clean up 
Empty buckets and delete them

aws s3 rb s3://server-logs-source-02102025 --force
aws s3 rb s3://server-logs-dest-02102025 --force


