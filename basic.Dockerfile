# Use Ubuntu as the base image
FROM ubuntu:latest

# Install Senzing API runtime dependencies and libraries
RUN apt-get update && apt-get install -y \
    curl \
    unzip \
    && apt-get clean

# Add Senzing as the runtime layer
FROM senzing/senzingapi-runtime

# Set a default command (optional)
CMD ["bash"]

