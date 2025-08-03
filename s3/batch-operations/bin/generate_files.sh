#!/bin/bash

# Define the directory to store the files (optional, creates if not exists)
OUTPUT_DIR="../files"
mkdir -p "$OUTPUT_DIR"

for i in {1..20}; do
  # Generate a random file size between 1 and 1000 bytes
  file_size=$(( RANDOM % 1000 + 1 ))

  # Generate a unique file name
  file_name="${OUTPUT_DIR}/file_${i}.txt"

  # Create a file with random content using /dev/urandom
  head -c "${file_size}" /dev/urandom > "${file_name}"

  echo "Created: ${file_name} (${file_size} bytes)"
done

echo "---"
echo "Done creating 20 files."