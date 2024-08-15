FROM debian:bookworm-slim

WORKDIR /app

# Install cron and dependencies
RUN apt-get update && apt-get install -y \
  cron \
  curl \
  ca-certificates \
  && rm -rf /var/lib/apt/lists/*

# https://docs.docker.com/engine/install/debian/

RUN install -m 0755 -d /etc/apt/keyrings
RUN curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
RUN chmod a+r /etc/apt/keyrings/docker.asc

RUN echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian bookworm stable" > /etc/apt/sources.list.d/docker.list

# Install Docker CLI
RUN apt-get update && apt-get install -y docker-ce-cli && rm -rf /var/lib/apt/lists/*

ADD ./start.sh ./start.sh

# Start the script as the entry point
ENTRYPOINT ["./start.sh"]

