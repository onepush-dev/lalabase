#!/bin/bash
set -e
mkdir -p /rails/storage /rails/tmp/cache/store /rails/tmp/pids
chown -R 1000:1000 /rails/storage /rails/tmp 2>/dev/null || true
exec setpriv --reuid=1000 --regid=1000 --init-groups -- /rails/railway/run.sh
