#!/bin/bash
set -e
cd /rails
if [ -z "${LD_PRELOAD+x}" ] && [ -f /usr/lib/*/libjemalloc.so.2 ]; then
  export LD_PRELOAD="$(echo /usr/lib/*/libjemalloc.so.2)"
fi
if [ -z "${LALABASE_HOST:-}" ] && [ -n "${RAILWAY_PUBLIC_DOMAIN:-}" ]; then export LALABASE_HOST="$RAILWAY_PUBLIC_DOMAIN"; fi
# Wait for the database (Railway starts services in parallel).
ruby -ruri -rsocket -e '
  u = URI(ENV.fetch("DATABASE_URL")); 120.times { |i|
    begin; Socket.tcp(u.host, u.port || 5432, connect_timeout: 2).close; exit 0
    rescue StandardError; warn "railway: waiting for database #{u.host} (#{i})" if i % 10 == 0; sleep 2; end }
  warn "railway: database not reachable"; exit 1'
./bin/rails db:prepare lalabase:data_backfills
if [ -n "${LALABASE_ADMIN_PASSWORD:-}" ] && [ ! -f /rails/storage/.railway-admin-created ]; then
  if ./bin/rails lalabase:setup; then touch /rails/storage/.railway-admin-created
  else echo "railway: lalabase:setup did not create an admin (one may exist already)"; touch /rails/storage/.railway-admin-created; fi
fi
exec ./bin/rails server -b '0.0.0.0' -p "${PORT:-8080}"
