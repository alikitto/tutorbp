FROM debian:stable-slim

# Ставим все нужные пакеты
RUN apt-get update && apt-get install -y \
    default-mysql-client \
    curl \
    gzip \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY scripts/ ./scripts/
COPY start.sh .
RUN chmod +x start.sh scripts/*.sh

CMD ["./start.sh"]
