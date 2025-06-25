# Use an official Ubuntu runtime as a parent image
FROM ubuntu:20.04

# Set environment variable for the port
ENV PORT=8080

ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends autossh git nano curl wget gnupg software-properties-common tzdata && \
    curl -fsSL https://code-server.dev/install.sh | sh && \
    apt-get purge -y systemd && \
    apt-get install -y --no-install-recommends systemctl tzdata && \
    apt-get clean && rm -rf /var/lib/apt/lists/* 

# Expose the correct port
EXPOSE $PORT

# Start code-server (listen on all interfaces)
CMD ["code-server", "--bind-addr", "0.0.0.0:8080", "--auth", "none"]
