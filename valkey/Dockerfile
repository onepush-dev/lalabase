# Valkey 8 (official valkey/valkey:8-alpine) for lalabase's Action Cable, password-protected,
# listening on IPv4 + IPv6 for Railway's private network. No persistence needed (pub/sub only).
FROM valkey/valkey:8-alpine@sha256:2602ace2be6569bc2bbb06f873776516ab9089821525be34f4305c67eb9db02a
CMD ["sh", "-c", "exec valkey-server --bind '* -::*' --port 6379 --requirepass \"$REDIS_PASSWORD\" --save '' --appendonly no"]
