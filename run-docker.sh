#!/bin/bash
SHELL_PATH=$(pwd)

# Define the name of the Docker image you want to check
image_name="torchserve:latest"

# Use Docker CLI to inspect the image and capture the output
image_info=$(docker image inspect "$image_name" 2>&1)

# Check if the image exists
if [[ $image_info == *"No such image"* ]]; then
  echo "Docker image '$image_name' does not exist."
  docker build --pull --rm -f "Dockerfile" -t torchserve:latest "."
else
  echo "Docker image '$image_name' exists."
  docker run \
    -itd \
    --rm \
    -u root \
    --gpus all \
    --shm-size=1g \
    -p 8080:8080 \
    -v $SHELL_PATH/torch-serve/:/home/torch-serve \
    torchserve:latest torchserve \
    --start \
    --model-store model-store \
    --models face-car-plate-window.mar \
    --foreground
fi


