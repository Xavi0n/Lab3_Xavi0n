#!/bin/bash

# Function to check if the BMP280 is connected
check_mpu9250() {

    local device_id

    # Read the device ID from the MPU9250 sensor
    device_id=$(i2cget -f -y 2 0x68 0x75)

    # Convert the read ID to decimal for comparison
    device_id_dec=$((device_id))

    # Check if the device ID matches the expected BMP280 ID
    if [ "$device_id_dec" -eq 113 ]; then
        echo "MPU-9250 detected at address 0x68 with device ID: $device_id"
        return 0
    else
        echo "No MPU-9250 found at address 0x68 (device ID: $device_id)"
        return 1
    fi
}

# Check the MPU9250 at address 0x68
if check_mpu9250; then
    echo "MPU-9250 is connected and functional."
else
    echo "No MPU-9250 detected at address 0x68."
    exit 1
fi

