#!/bin/bash
set -e

BACKUP_SCHEDULE=${BACKUP_SCHEDULE:-0 3 * * *}

printenv | sed 's/\(.*\)/export \1/g' > /app/env.sh
chmod +x /app/env.sh
echo "$BACKUP_SCHEDULE root /bin/bash -lc '. /app/env.sh; /app/backup.sh' >> /var/log/backup.log 2>&1" > /etc/cron.d/backup
chmod 0644 /etc/cron.d/backup
crontab /etc/cron.d/backup
/bin/bash -lc '. /app/env.sh; /app/backup.sh' || true
touch /var/log/backup.log
exec cron -f
