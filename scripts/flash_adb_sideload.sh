#!/bin/bash

# Set the path to the parent directory
PARENT_DIR="$(dirname "$0")/.."
OTA_ZIP=""

# Look for any ZIP file in the parent directory
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

# Prompt the user to format data
read -p "Do you want to format data? (Y/N): " FORMAT_DATA
if [[ "$FORMAT_DATA" =~ ^[Yy]$ ]]; then
    echo "Formatting data..."
    fastboot -w
else
    echo "Skipping data format. Proceeding with flashing..."
fi

# Reboot the device into recovery mode
echo "Rebooting device into recovery mode..."
fastboot reboot recovery

# Wait for the device to enter ADB sideload mode
echo "Waiting for device to enter ADB sideload mode..."
while ! adb devices | grep -q "sideload"; do
    sleep 5
done

# Start sideloading the ROM ZIP file
echo "Device is in sideload mode. Starting sideload..."
adb sideload "$OTA_ZIP"

echo "Sideloading completed."
