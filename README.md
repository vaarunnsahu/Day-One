# Project Setup and Deployment Guide

This guide will help you to set up and run a Flask-based application locally, containerize it using Docker, and deploy it to Amazon Web Services (AWS) Elastic Container Registry (ECR) and EC2. It also covers important commands for managing Docker images and containers efficiently.

## Table of Contents

1. [Run the App Locally](#run-the-app-locally)
    - Setting up Virtual Environment
    - Installing Dependencies
    - Running the Application
2. [Build and Run the Docker Image](#build-and-run-the-docker-image)
    - Writing the Dockerfile
    - Building and Running the Docker Image
    - Pushing the Image to Docker Hub
3. [Push Docker Image to AWS ECR](#push-docker-image-to-aws-ecr)
    - Configuring AWS CLI
    - ECR Login and Image Push
4. [Deploy the App on AWS EC2](#deploy-the-app-on-aws-ec2)
    - Launch EC2 Instance
    - Configure EC2 Role and Permissions
5. [Important Docker Commands](#important-docker-commands)
    - Managing Docker Images
    - Managing Docker Containers

---

## Run the App Locally

Follow these steps to run the application locally on your development machine.

### 1. Setup Virtual Environment

First, create a virtual environment to manage the dependencies for the project:

```bash
python3 -m venv bootcamp
```

Activate the virtual environment:

- On macOS/Linux:
  ```bash
  source bootcamp/bin/activate
  ```

- On Windows:
  ```bash
  bootcamp\Scripts\activate
  ```

### 2. Install App Dependencies

Next, install the necessary dependencies for the application:

```bash
pip install -r requirements.txt
```

### 3. Run the App

Now, run the Flask application:

```bash
python first-dummy-app.py
```

The application will be available on your local machine at:

```
http://127.0.0.1:5000
```

---

## Build and Run the Docker Image

You can containerize the application using Docker for a more consistent and portable environment.

### 1. Write the Dockerfile

Ensure that your project has a `Dockerfile` that contains the necessary instructions to create a Docker image. This file typically defines the base image, dependencies, and the commands needed to run the application.

### 2. Build and Run the Docker Image

To build the Docker image, use the following command from the directory containing your `Dockerfile`:

```bash
docker build -t flask .
```

For platform compatibility, especially when building on one platform (e.g., Windows) and running on another (e.g., Linux), use the following:

```bash
docker build -t <your-repo-name>/bootcampflask:v2 --platform=linux/amd64 .
```

### 3. Push Docker Image to Docker Hub

After building the image, push it to your Docker Hub repository:

```bash
docker push <your-repo-name>/bootcampflask:v2
```

---

## Push Docker Image to AWS ECR

Follow these steps to push your Docker image to Amazon ECR (Elastic Container Registry) for AWS cloud deployment.

### 1. Configure AWS CLI

Make sure you have the AWS CLI installed and configured with your AWS credentials:

```bash
aws configure
```

### 2. ECR Login and Image Push

- First, log in to your AWS ECR using the following command:

  ```bash
  aws ecr get-login-password --region <your-region> | docker login --username AWS --password-stdin <aws-account-id>.dkr.ecr.<aws-region>.amazonaws.com
  ```

  For example, if your region is `ap-south-1`, the command will look like this:

  ```bash
  aws ecr get-login-password --region ap-south-1 | docker login --username AWS --password-stdin 366140438193.dkr.ecr.ap-south-1.amazonaws.com
  ```

- Tag the Docker image to match the ECR repository:

  ```bash
  docker tag <image-name>:v2 <aws-account-id>.dkr.ecr.<aws-region>.amazonaws.com/<ecr-repository-name>:v2
  ```

- Push the Docker image to ECR:

  ```bash
  docker push <aws-account-id>.dkr.ecr.<aws-region>.amazonaws.com/<ecr-repository-name>:v2
  ```

---

## Deploy the App on AWS EC2

### 1. Launch EC2 Instance

- Create an EC2 instance with the necessary security groups to allow traffic on port 5000 (for Flask) and port 22 (for SSH access).
- Ensure that the EC2 instance has an IAM role with the correct permissions for accessing ECR.

### 2. Configure EC2 Role and Permissions

Ensure that the EC2 instance has the proper IAM role to pull images from ECR. This role should have the `AmazonEC2ContainerRegistryReadOnly` policy attached.

---

## Important Docker Commands

Below are some useful Docker commands for managing your Docker environment.

### 1. Delete All Docker Images

To delete all Docker images at once:

```bash
docker rmi $(docker images -q)
```

### 2. Delete All Docker Containers

To delete all Docker containers:

```bash
docker rm $(docker ps -aq)
```

### 3. Listing Processes Using a Specific Port

To list processes that are using a specific port (for example, port 5000):

```bash
lsof -i :5000
```

---

## Conclusion

This guide provides detailed steps for running a Flask application locally, containerizing it with Docker, and pushing it to AWS for cloud deployment. By following this process, you can easily deploy your app to both local and cloud environments, making your development process more scalable and efficient.
