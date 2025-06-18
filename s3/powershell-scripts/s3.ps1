Import-Module AWS.Tools.s3

$region = "us-east-1"
$bucketName = Read-Host "Enter the S3 bucket name"

Write-Host "AWS Region: $region"
Write-Host "AWS Bucket: $bucketName" 

function BucketExists {
     $bucket= Get-S3Bucket -BucketName $bucketName -ErrorAction SilentlyContinue
    if ($bucket) {
        Write-Host "Bucket $bucketName already exists."
        return $true
    } else {
        Write-Host "Bucket $bucketName does not exist."
        return $false
    }
}   
    
# Check if the bucket exists
if (BucketExists) {
                
} else {
    # Create the bucket if it does not exist
    New-S3Bucket -BucketName $bucketName -Region $region
    Write-Host "Bucket $bucketName created successfully."
}   


# Create a new file
$fileName = "example.txt"
$fileContent = "This is an example file."

Set-Content -Path $fileName -Value $fileContent
Write-Host "File created: $fileName"    
# Upload the file to the S3 bucket
Write-Host "Uploading file to S3 bucket..."
try {           
    Write-S3Object -BucketName $bucketName -File $fileName -Key $fileName -Region $region
    Write-Host "File uploaded successfully to bucket $bucketName."
} catch {
    Write-Host "Error uploading file: $_"
}