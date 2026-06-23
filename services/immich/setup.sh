#!/bin/bash

ENV_FILE=".env"

if [ ! -f "$ENV_FILE" ]; then
    echo ".env file not found. Creating a new one..."
    RANDOM_PASS=$(LC_ALL=C tr -dc 'A-Za-z0-9!@#%^&*()-_=+' < /dev/urandom | head -c 32)

    {
        echo "DB_DATABASE_NAME=immich"
        echo "DB_USERNAME=postgres"
        echo "DB_PASSWORD=$RANDOM_PASS"
        echo "DB_DATA_LOCATION=/mnt/user/appdata/immich/postgres"
        echo "UPLOAD_LOCATION=/mnt/user/appdata/immich/upload"
    } > "$ENV_FILE"

    echo ".env file created successfully."
else
    echo ".env file already exists."
fi