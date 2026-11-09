# lalabase on Railway

lalabase — open-source project management and client portal for dev agencies: tickets, projects, time tracking and a portal for your clients. Deploy on Railway with one click.

[![Deploy on Railway](https://railway.com/button.svg)](https://railway.com/deploy/mGvvQA)

This repository packages the official [lalabase](https://github.com/lalabase/lalabase) release image (`ghcr.io/lalabase/lalabase:2026.11.0`, AGPL-3.0) for Railway, unmodified apart from packaging. It is an independent community packaging, not the official lalabase distribution and not affiliated with or endorsed by its makers. "Lalabase" is a registered trademark of gboyke solutions UG; see upstream's [TRADEMARKS.md](https://github.com/lalabase/lalabase/blob/main/TRADEMARKS.md).

## Services

| Service | Image | Notes |
|---|---|---|
| `lalabase` | `ghcr.io/onepush-dev/lalabase:2026.11.0` (official image + start script) | Puma web app with Solid Queue jobs in-process; uploads on a volume at `/rails/storage`; health `/up` |
| `Postgres` | `ghcr.io/onepush-dev/lalabase-postgres:17` (= `pgvector/pgvector:pg17`, db/user `lalabase`) | Volume at `/var/lib/postgresql/data` |
| `Valkey` | `ghcr.io/onepush-dev/lalabase-valkey:8` (= `valkey/valkey:8-alpine`, password-protected) | Action Cable pub/sub (private only) |

Upstream's compose runs a separate `worker` container; on Railway a volume can't be shared between services, so jobs run inside Puma (`SOLID_QUEUE_IN_PUMA`, supported by upstream's `config/puma.rb`). Caddy is replaced by Railway's HTTPS.

## Use it

1. Instance admin: open `https://<your-domain>/admin` and sign in as `admin@example.com` with `LALABASE_ADMIN_PASSWORD` (Variables tab). It is created on first boot, so nobody else can claim it. Change the email/password there.
2. Your team: register the first user at `/users/sign_up` (each sign-up creates its own organisation). Turn public registration off in **/admin → System settings** if you only want invited users.
3. Email (confirmations, invitations, notifications): set `SMTP_ADDRESS`, `SMTP_PORT`, `SMTP_DOMAIN`, `SMTP_USERNAME`, `SMTP_PASSWORD` on the `lalabase` service. Without SMTP, unconfirmed accounts work for 3 days; confirm them from /admin.

## Notes

- Secrets (`SECRET_KEY_BASE`, Active Record encryption keys, database and Valkey passwords) are generated per deploy. Keep the encryption keys: encrypted fields can't be read without them.
- Back up the Postgres volume and the `/rails/storage` volume.
