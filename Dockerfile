# lalabase on Railway: the official release image (ghcr.io/lalabase/lalabase:2026.11.0, AGPL-3.0),
# application unmodified (packaging changes only, per upstream's trademark policy), plus a start
# script that:
#   - hands the root-owned Railway volume (/rails/storage, uploaded files) to the image's uid 1000;
#   - waits for Postgres, runs upstream's own db:prepare + data backfills;
#   - creates the first instance admin from LALABASE_ADMIN_EMAIL / LALABASE_ADMIN_PASSWORD
#     (upstream's `rails lalabase:setup`; a no-op once an admin exists), so nobody can claim /admin;
#   - runs Solid Queue inside Puma (SOLID_QUEUE_IN_PUMA), because Railway volumes can't be shared
#     between a web and a worker service and both need the uploaded files.
FROM ghcr.io/lalabase/lalabase:2026.11.0@sha256:c38a122e7ccb03299422138c83eb9288dd1b5a3845c304ac517ca1c5390104d9
USER root
COPY railway/ /rails/railway/
RUN chmod 755 /rails/railway/*.sh
ENV PORT=8080 \
    SOLID_QUEUE_IN_PUMA=1 \
    RAILS_MAX_THREADS=5 \
    LALABASE_ADMIN_EMAIL=admin@example.com
EXPOSE 8080
ENTRYPOINT ["/rails/railway/start.sh"]
CMD []
