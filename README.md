# Lambda Layer Creation with Docker

This repository contains a bash script and Dockerfile to automate the creation of a Lambda Layer for AWS Lambda functions using Docker. The layer includes Python dependencies specified in `requirements.txt`, and the output is a zipped Lambda Layer ready for deployment.

## Prerequisites

- Docker installed and running on your machine
- `requirements.txt` file listing the Python dependencies you want to include in the layer
- Bash terminal (if on Windows, use Git Bash or WSL)

## Files

- `create_layer.sh`: Bash script to build the Docker image, run a container to package the Python dependencies, and extract the zipped Lambda Layer.
- `Dockerfile`: Defines the container setup, including installing Python packages and zipping the contents for Lambda Layer use.
- `requirements.txt`: List of Python packages to include in the Lambda Layer.

## Usage

### Step 1: Prepare your environment
1. Ensure you have a `requirements.txt` file in the same directory where the scripts are located.
2. Set the desired layer name in the `create_layer.sh` script by updating the `LAYER_NAME` variable:
   ```bash
   LAYER_NAME="your-layer-name"

### Step 2: Run the Bash Script

Execute the bash script to build the Docker image and generate the layer:
```bash
bash create_layer.sh
```
This script will:

1. Build a Docker image using the Dockerfile and tag it as lambda-layer.
2. Run the container and package the dependencies into a zip file.
3. Copy the resulting zip file to the layers/ directory.

### Step 3: Verify the Output
After running the script, check the `layers` directory for the resulting `.zip` file:

```bash
layers/
├── your-layer-name.zip
```

This `.zip` file is your Lambda Layer, which can be uploaded to AWS Lambda for use in your functions.

### Important Note

In both the `create_layer.sh` script and the `Dockerfile`, make sure to change `/app/openai-layer.zip` to reflect the value of the `LAYER_NAME` variable you set in the bash script.

For example, if you set `LAYER_NAME="my-custom-layer"`, update the `CMD` in the `Dockerfile` as follows:

```Dockerfile
CMD cd /opt && zip -r9 /app/my-custom-layer.zip .
```

This ensures the zip file is named correctly during the packaging process.

### Step 4: Clean Up
Once the layer is created, the script will remove the Docker container and image. If you'd like to keep them for future use, comment out the cleanup section at the bottom of `create_layer.sh`:

```bash
# docker stop lambda-layer-container
# docker rm lambda-layer-container
# docker rmi --force lambda-layer
```

By commenting these lines out, the Docker container and image will remain on your system for future use.