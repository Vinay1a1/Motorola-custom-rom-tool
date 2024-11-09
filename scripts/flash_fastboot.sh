#!/bin/bash

# Look for any ZIP file in the parent directory
PARENT_DIR="$(dirname "$0")/.."
OTA_ZIP=""

for f in "$PARENT_DIR"/*.zip; do
    if [[ -f "$f" ]]; then
        OTA_ZIP="$f"
        break
    fi
done

# Check if an OTA ZIP file was found
if [[ -z "$OTA_ZIP" ]]; then
    echo "No OTA ZIP file found in the parent directory."
    exit 1
else
    echo "Found OTA ZIP file: $OTA_ZIP"
fi

# Create a temporary directory for extraction
TEMP_DIR="$(dirname "$0")/extracted"
mkdir -p "$TEMP_DIR"

# Extract OTA ZIP using payload-dumper-go
echo "Extracting OTA ZIP file..."
"$(dirname "$0")/../bin/payload-dumper-go" -o "$TEMP_DIR" "$OTA_ZIP"

# Change to the temporary directory
cd "$TEMP_DIR" || exit 1

# Flash images using fastboot
echo "Flashing images using fastboot..."

fastboot flash boot boot.img
fastboot flash vbmeta vbmeta.img
fastboot flash vbmeta_system vbmeta_system.img
fastboot flash vendor_boot vendor_boot.img
fastboot reboot fastboot
fastboot flash product product.img
fastboot flash system system.img
fastboot flash system_ext system_ext.img
fastboot flash vendor vendor.img
fastboot flash vendor_dlkm vendor_dlkm.img

# Prompt user to format data
read -p "Do you want to format data? (Y/N): " FORMAT_DATA
if [[ "$FORMAT_DATA" =~ ^[Yy]$ ]]; then
    echo "Formatting data..."
    fastboot -w
else
    echo "Skipping data format. Proceeding with flashing..."
fi

echo "Flashing complete."
