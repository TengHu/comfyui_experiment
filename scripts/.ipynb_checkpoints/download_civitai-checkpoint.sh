#!/bin/bash

# Check if correct number of parameters are provided
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <url> <destination>"
    echo "Example: $0 'https://example.com/file' '/path/to/destination'"
    exit 1
fi

# Check if CIVITAI_API_KEY is set
if [ -z "$CIVITAI_API_KEY" ]; then
    echo "Error: CIVITAI_API_KEY environment variable is not set"
    echo "Please set it using: export CIVITAI_API_KEY=your_api_key"
    exit 1
fi

# Assign parameters to variables
URL="$1"
DESTINATION="$2"

# Check if destination directory exists, if not create it
if [ ! -d "$DESTINATION" ]; then
    echo "Creating destination directory: $DESTINATION"
    mkdir -p "$DESTINATION"
fi

# Change to destination directory
cd "$DESTINATION" || exit 1


# Execute wget command with parameters and API key from environment variable 
wget "${URL}&token=${CIVITAI_API_KEY}" --content-disposition

# Check if download was successful
if [ $? -eq 0 ]; then
    echo "Download completed successfully to $DESTINATION"
else
    echo "Error occurred during download"
    exit 1
fi