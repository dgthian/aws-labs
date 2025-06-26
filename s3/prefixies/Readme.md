## Create our bucket
```sh
aws s3 mb s3://prefixies-fun-dgt-26062025
```

## Create our folder
```sh
aws s3api put-object --bucket="prefixies-fun-dgt-26062025" --key="hello/"
```

## Create many folders
```sh
aws s3api put-object --bucket="prefixies-fun-dgt-26062025" --key="Lorem/ipsum/dolor/sit/amet,/consectetur/adipiscing/elit./Donec/lacus/arcu,/sollicitudin/vitae/lorem/ut,/aliquam/pharetra/lectus./Nullam/accumsan/dapibus/purus,/a/porttitor/dui/finibus/non./Sed/interdum/placerat/neque/ac/egestas./Suspendisse/nunc/dolor,/mattis/elementum/massa/vitae,/fringilla/rutrum/lectus./Done/"
```

 
## Try to break the 1024 limit 
```sh
aws s3api put-object --bucket="prefixies-fun-dgt-26062025" --key="Lorem/ipsum/dolor/sit/amet,/consectetur/adipiscing/elit./Donec/lacus/arcu,/sollicitudin/vitae/lorem/ut,/aliquam/pharetra/lectus./Nullam/accumsan/dapibus/purus,/a/porttitor/dui/finibus/non./Sed/interdum/placerat/neque/ac/egestas./Lorem/ipsum/dolor/sit/amet,/consectetur/adipiscing/elit./Donec/lacus/arcu,/sollicitudin/vitae/lorem/ut,/aliquam/pharetra/lectus./Nullam/accumsan/dapibus/purus,/a/porttitor/dui/finibus/non./Sed/interdum/placerat/neque/ac/egestas./Suspendisse/nunc/dolor,/mattis/elementum/massa/vitae,/fringilla/rutrum/lectus./Done/hello.txt" --body="hello.txt"
```

