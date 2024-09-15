#!/bin/bash

# Set the directory where the Dockerfile and requirements.txt are located
DIRECTORY="$(pwd)"

# Change it as per your requirement
LAYER_NAME="openai-layer"

# Build the Docker image
docker build -t lambda-layer "$DIRECTORY"

# Run the Docker container to create the layer
docker run --name lambda-layer-container -v "$DIRECTORY:/app" lambda-layer

# create layers directory, if not created.
mkdir -p layers

## Move the zip file to layers directory if it was created successfully
# if [ -f "$DIRECTORY/$LAYER_NAME.zip" ]; then
#     mv "$DIRECTORY/$LAYER_NAME.zip" "$DIRECTORY/layers/$LAYER_NAME.zip"
# else
#     echo "Error: Zip file not found!"
#     exit 1

docker cp "lambda-layer-container:/app/$LAYER_NAME.zip" layers/ # use this command especially if you're working on a Windows machine.

# Stop the conainer
docker stop lambda-layer-container

# Remove the running conainer
docker rm lambda-layer-container

# Cleanup: remove the Docker image
docker rmi --force lambda-layer
