FROM debian:bookworm

RUN apt-get update && apt-get install -y \
    mariadb-client \
    tar \
    gzip \
    cron \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY tools/backup.sh /app/backup.sh
COPY tools/entrypoint.sh /app/entrypoint.sh
RUN chmod +x /app/backup.sh /app/entrypoint.sh

ENTRYPOINT ["/app/entrypoint.sh"]
