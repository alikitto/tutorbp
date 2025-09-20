FROM debian:stable-slim

# Установим только mysql-client, curl, gzip, unzip
RUN apt-get update && apt-get install -y \
    default-mysql-client \
    curl \
    gzip \
    unzip \
    && rm -rf /var/lib/apt/lists/*

# Ставим AWS CLI v2 напрямую (без pip)
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" \
    && unzip awscliv2.zip \
    && ./aws/install \
    && rm -rf awscliv2.zip aws

WORKDIR /app

COPY scripts/ ./scripts/
COPY start.sh .
RUN chmod +x start.sh scripts/*.sh

CMD ["./start.sh"]
