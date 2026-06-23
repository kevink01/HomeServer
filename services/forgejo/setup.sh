#!/bin/bash

ENV_FILE=".env"

if [ ! -f "$ENV_FILE" ]; then
    echo ".env file not found. Creating a new one..."
    RANDOM_PASS=$(LC_ALL=tr -dc 'A-Za-z0-9!@#%^&*()-_=+' < /dev/urandom | head -c 32)

    {
        echo "POSTGRES_DB=forgejo"
        echo "POSTGRES_USER=forgejo"
        echo "POSTGRES_PASSWORD=$RANDOM_PASS"
    } > "$ENV_FILE"

    echo ".env file created successfully."
else
    echo ".env file already exists."
fi