## Create a new s3 bucket

```md
aws s3 mb s3://checksums-example-dgt-23062025
```

## Create a file that will we do a checksum on

```
echo "Hello Djibril " > myfile.txt
```

## Get a checksum of a file for md5
md5sum myfile.txt 

# 4bb56f5984b685fc4c0f830f9a51e8e3  myfile.txt

## Upload our file

```
aws s3 cp myfile.txt s3://checksums-example-dgt-23062025
aws s3api head-object --bucket checksums-example-dgt-23062025 --key myfile.txt
```
## Lets upload a file with a different kind 
of checksum
```sh
bundle exec ruby crc.rb
```

```sh
aws s3 put-object \
--bucket="checksums-example-dgt-23062025" \
--key="myfilecrc32.txt" \
--body="myfile.txt" \
--checksum-algorithm="SHA1" \
--checksum-sha1="e447111810ef69c320a570379515265b764c7594"
```