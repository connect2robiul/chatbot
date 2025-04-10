# Use the official Python Alpine image for a smaller footprint
FROM python:3.10-alpine

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Install system dependencies and clean up after installation
RUN apk add --no-cache --virtual .build-deps gcc libc-dev && \
    pip install --no-cache-dir --upgrade pip setuptools && \
    apk del .build-deps

# Set the working directory in the container
WORKDIR /app

# Copy the requirements.txt
COPY requirements.txt .

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application
COPY . .

# Expose the port Flask will run on
EXPOSE 5000

# Command to run the app
CMD ["python", "app.py"]
