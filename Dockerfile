# Use the official Python 3.9 image from the Docker Hub (more specific version)
FROM python:3.9-slim-buster

# Metadata as a label to improve the container’s identification and management in CI/CD
LABEL maintainer="your-email@example.com"
LABEL version="1.0"
LABEL description="Flask Application Container for First Dummy App"

# Set a working directory for the app
WORKDIR /app

# Copy the requirements file first to leverage Docker caching effectively
COPY requirements.txt /app/

# Install necessary Python dependencies in a single layer
RUN pip install --no-cache-dir -r requirements.txt

# Copy the application code into the container (separate the code copy from requirements for optimization)
COPY first-dummy-app.py /app/

# Add a default environment variable that defines the Flask application entry point
ENV FLASK_APP=first-dummy-app.py

# Expose port 5000 to allow the app to communicate externally
EXPOSE 5000

# Health check to ensure the container is running smoothly and your Flask app is healthy
HEALTHCHECK CMD curl --fail http://localhost:5000/ || exit 1

# Add a user (non-root) for security purposes
RUN useradd -m flaskuser && chown -R flaskuser:flaskuser /app
USER flaskuser
#new
# Command to run Flask app on all available network interfaces inside the container
CMD ["flask", "run", "--host=0.0.0.0", "--port=5000"]
