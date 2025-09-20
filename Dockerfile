FROM debian:stable-slim

RUN apt-get update && apt-get install -y \
    default-mysql-client \
    curl \
    gzip \
    unzip \
    python3 \
    python3-pip \
    && pip3 install awscli \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY scripts/ ./scripts/
COPY start.sh .
RUN chmod +x start.sh scripts/*.sh

CMD ["./start.sh"]
