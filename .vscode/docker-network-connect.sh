#!/bin/sh

DEVCONTAINER_NETWORK_NAME=$1
if [ -z "$DEVCONTAINER_NETWORK_NAME" ]; then
    echo "Please provide network to connect to"
    exit 1;
fi

# Get devcontainer's network information
NETWORK_COUNT=$(docker inspect $HOSTNAME | jq -r ".[].NetworkSettings.Networks | .$DEVCONTAINER_NETWORK_NAME | length")
# Check for duplicate connection
if [ $NETWORK_COUNT -eq 0 ]; then
    docker network connect $DEVCONTAINER_NETWORK_NAME $HOSTNAME
    echo "Connected to $DEVCONTAINER_NETWORK_NAME"
else
    echo "Already connected to network or network not found."
fi
