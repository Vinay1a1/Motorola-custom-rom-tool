#!/bin/bash

# Set the path to the parent directory
PARENT_DIR="$(dirname "$0")/.."

# Look for any ZIP file in the parent directory
OTA_ZIP=""
for f in "$PARENT_DIR"/*.zip; do
    if [ -f "$f" ]; then
        OTA_ZIP="$f"
        break
    fi
done

# Check if an OTA ZIP file was found
if [ -z "$OTA_ZIP" ]; then
    echo "No OTA ZIP file found in the parent directory."
    exit 1
else
    echo "Found OTA ZIP file: $OTA_ZIP"
fi

# Create a temporary directory for extraction
TEMP_DIR="$PARENT_DIR/extracted"
mkdir -p "$TEMP_DIR"

# Extract OTA ZIP using payload-dumper-go
echo "Extracting OTA ZIP file..."
"$PARENT_DIR/bin/payload-dumper-go" -p boot -o "$TEMP_DIR" "$OTA_ZIP"

# Move boot.img to the main folder
if [ -f "$TEMP_DIR/boot.img" ]; then
    mv "$TEMP_DIR/boot.img" "$PARENT_DIR"
    echo "Moved boot.img to the main folder."
else
    echo "boot.img not found in the extracted files."
fi
