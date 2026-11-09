# PostgreSQL 17 with pgvector for lalabase (official pgvector/pgvector:pg17), unmodified.
# Database/user names are baked in because Railway templates drop plain variable values;
# PGDATA is a subfolder so the root of the Railway volume (lost+found) stays out of initdb's way.
FROM pgvector/pgvector:pg17@sha256:7d0a41464797aeb9862dfdc0bbf1526b82cfd324cdd8036df19e3545f4a9ccb8
ENV POSTGRES_USER=lalabase \
    POSTGRES_DB=lalabase \
    PGDATA=/var/lib/postgresql/data/pgdata
