#!/bin/sh

cat > ${CONFIG_FOLDER:-/config}/aria2.conf <<EOF
enable-rpc=true
rpc-listen-all=true
rpc-secret=${RPC_SECRET:-}
dir=${DOWNLOAD_DIR:-/downloads}
log=${CONFIG_FOLDER:-/config}/aria2.log
max-concurrent-downloads=${CONCURRENT_DOWNLOADS:-10}
split=${SPLIT:-4}
max-connection-per-server=${CONNECTIONS_PER_SERVER:-4}
user-agent=${USER_AGENT:-}
file-allocation=${FILE_ALLOCATION:-none}
allow-overwrite=${ALLOW_OVERWRITE:-true}
auto-file-renaming=${AUTO_FILE_RENAMING:-false}

disable-ipv6=true

input-file=${CONFIG_FOLDER:-/config}/aria2.session
save-session=${CONFIG_FOLDER:-/config}/aria2.session

log-level=${LOG_LEVEL:-warn}
enable-http-pipelining=${HTTP_PIPELINE:-true}

max-connection-per-server=${MAX_CONNECTION_PER_SERVER:-10}
min-split-size=${MIN_SPLIT_SIZE:-10M}

continue=${CONTINUE:-true}
max-overall-download-limit=0
max-overall-upload-limit=1K
dht-file-path=${CONFIG_FOLDER:-/config}/dht.dat
dht-file-path6=${CONFIG_FOLDER:-/config}/dht6.dat
save-cookies=${CONFIG_FOLDER:-/config}/cookies.dat


EOF

exec "$@"
