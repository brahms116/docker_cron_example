FROM debian:bookworm-slim

WORKDIR /app

# Install cron and dependencies
RUN apt-get update && apt-get install -y \
  gnupg \
  cron \
  curl \
  ca-certificates \
  && rm -rf /var/lib/apt/lists/*

# Add Docker’s official GPG key
RUN curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -

# Add Docker’s official APT repository
# Note that the architecture is specified as arm64, replace with your own or use $(dpkg --print-architecture)
RUN echo "deb [arch=arm64] https://download.docker.com/linux/debian bookworm stable" > /etc/apt/sources.list.d/docker.list

# Install Docker CLI
RUN apt-get update && apt-get install -y docker-ce-cli && rm -rf /var/lib/apt/lists/*

ADD ./start.sh ./start.sh

# Start the script as the entry point
ENTRYPOINT ["./start.sh"]

