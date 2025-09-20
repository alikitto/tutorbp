#!/bin/bash
set -eo pipefail

echo ">>> Starting database backup..."

FILENAME="db_backup_$(date +'%Y-%m-%d_%H-%M-%S').sql.gz"
FILEPATH="/tmp/$FILENAME"

# Делаем дамп
mysqldump -u"$DB_USER" -p"$DB_PASS" -h"$DB_HOST" -P"$DB_PORT" "$DB_NAME" \
  | gzip > "$FILEPATH"

echo ">>> Uploading to Cloudflare R2..."
aws s3 cp "$FILEPATH" s3://$S3_BUCKET/$FILENAME \
  --endpoint-url https://$R2_ACCOUNT_ID.r2.cloudflarestorage.com

rm "$FILEPATH"
echo ">>> Backup uploaded successfully to R2 bucket $S3_BUCKET"
