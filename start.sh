#!/bin/bash

CRON_JOB="* * * * * docker run --rm -e CONTENT=$CONTENT demo-service >> /app/cron.log 2>&1"

# Add the cron job to the crontab
(crontab -l 2>/dev/null; echo "$CRON_JOB") | crontab -

echo "Cron job added to crontab with content: $CONTENT"

cron -f
