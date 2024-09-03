#!/bin/bash

# Function to check if the BMP280 is connected
check_bmp280() {

    local device_id

    # Read the device ID from the BMP280 sensor
    device_id=$(i2cget -f -y 2 0x76 0xD0)

    # Convert the read ID to decimal for comparison
    device_id_dec=$((device_id))

    # Check if the device ID matches the expected BMP280 ID
    if [ "$device_id_dec" -eq 88 ]; then
        echo "BMP280 detected at address 0x76 with device ID: $device_id"
        return 0
    else
        echo "No BMP280 found at address 0x76 (device ID: $device_id)"
        return 1
    fi
}

# Check the BMP280 at address 0x76
if check_bmp280; then
    echo "BMP280 is connected and functional."
else
    echo "No BMP280 detected at address 0x76."
    exit 1
fi
