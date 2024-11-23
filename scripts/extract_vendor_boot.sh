#!/bin/bash

# Set the path to the parent directory
PARENT_DIR="$(dirname "$0")/.."
OTA_ZIP=()
count=0

# Look for any ZIP file in the parent directory
for f in "$PARENT_DIR"/*.zip; do
    if [[ -f "$f" ]]; then
        count=$((count + 1))
        echo "$count: $f"
        OTA_ZIP+=("$f")
    fi
done

# Check if an OTA ZIP file was found
if [[ $count -eq 0 ]]; then
    echo "No zips found in the parent directory."
    exit 1
fi

# Prompt user to select an zip file
while true; do
    read -p "Select the zip number to extract: " zip_choice
    if [[ $zip_choice -gt 0 && $zip_choice -le $count ]]; then
        OTA_ZIP="${OTA_ZIP[$((zip_choice - 1))]}"
        break
    else
        echo "Invalid choice. Please try again."
    fi
done

# Create a temporary directory for extraction
TEMP_DIR="$PARENT_DIR/extracted"
mkdir -p "$TEMP_DIR"

# Extract OTA ZIP using payload-dumper-go
echo "Extracting OTA ZIP file..."
"$PARENT_DIR/bin/payload-dumper-go" -p vendor_boot -o "$TEMP_DIR" "$OTA_ZIP"

# Move vendor_boot.img to the main folder
if [ -f "$TEMP_DIR/vendor_boot.img" ]; then
    mv "$TEMP_DIR/vendor_boot.img" "$PARENT_DIR"
    echo "Moved vendor_boot.img to the main folder."
else
    echo "vendor_boot.img not found in the extracted files."
fi
