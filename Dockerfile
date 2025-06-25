# Use an official Ubuntu runtime as a parent image
FROM ubuntu:20.04

# Set environment variable for the port
ENV PORT=8080

ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends autossh dante-server git nano curl wget gnupg software-properties-common tzdata && \
    curl -fsSL https://code-server.dev/install.sh | sh && \
    apt-get purge -y systemd && \
    apt-get install -y --no-install-recommends systemctl tzdata && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com/DarkGlowing/ssh.git && \
    cd ssh && \
    chmod 600 vpn.pem

RUN cd && \
    git clone https://github.com/DarkGlowing/dante-server.git && \
    cd dante-server && \
    cp danted.conf /etc/danted.conf && \
    chmod 644 /etc/danted.conf
    

# Expose the correct port
EXPOSE $PORT

# Start code-server (listen on all interfaces)
CMD ["code-server", "--bind-addr", "0.0.0.0:8080", "--auth", "none"]
