#!/bin/bash
set -e

# Устанавливаем mysql-client вручную (Railpack образ обычно Debian/Ubuntu)
apt-get update -y && apt-get install -y default-mysql-client curl gzip

bash scripts/entrypoint.sh
