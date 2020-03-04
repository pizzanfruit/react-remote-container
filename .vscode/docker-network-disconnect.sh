# !/bin/sh


DEVCONTAINER_NETWORK_NAME=$1
if [ -z "$DEVCONTAINER_NETWORK_NAME" ]; then
    echo "Please provide network to disconnect from"
    exit 1;
fi

docker network disconnect $DEVCONTAINER_NETWORK_NAME $HOSTNAME
