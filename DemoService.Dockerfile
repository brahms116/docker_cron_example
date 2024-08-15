FROM debian:bookworm-slim

WORKDIR /app

ADD ./task.sh ./task.sh

ENTRYPOINT ["./task.sh"]
