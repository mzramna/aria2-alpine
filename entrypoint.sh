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
input-file=${CONFIG_FOLDER:-/config}/aria2.input
save-session=${CONFIG_FOLDER:-/config}/aria2.session
log-level=${LOG_LEVEL:-warn}
enable-http-pipelining=${HTTP_PIPELINE:-true}
min-split-size=${MIN_SPLIT_SIZE:-10M}
continue=${CONTINUE:-true}
max-overall-download-limit=${MAX_OVERALL_DOWNLOAD_LIMIT:-0}
max-overall-upload-limit=${MAX_OVERALL_UPLOAD_LIMIT:-1K}
dht-file-path=${CONFIG_FOLDER:-/config}/dht.dat
dht-file-path6=${CONFIG_FOLDER:-/config}/dht6.dat
save-cookies=${CONFIG_FOLDER:-/config}/cookies.dat
on-bt-download-complete=${CONFIG_FOLDER:-/config}/mvcompleted.sh
on-download-complete=${CONFIG_FOLDER:-/config}/mvcompleted.sh
EOF

cat > ${CONFIG_FOLDER:-/config}/mvcompleted.sh <<EOF
#!/bin/sh
 
# \$1 is gid.
# \$2 is the number of files.
# \$3 is the path of the first file.
 
DOWNLOAD=${DOWNLOAD_DIR:-/downloads} # no trailing slash!
COMPLETE=${COMPLETE_DOWNLOAD_DIR:-/downloads/download_complete} # no trailing slash!
LOG=${CONFIG_FOLDER:-/config}/mvcompleted.log
SRC=\$3
 
if [ "\$2" == "0" ]; then
  echo `\date` "INFO  no file to move for" "\$1". >> "\$LOG"
  exit 0
fi
 
while true; do
  DIR=`dirname "\$SRC"`
  if [ "\$DIR" == "\$DOWNLOAD" ]; then
    mv -fv "\$SRC" "\$COMPLETE" >> "\$LOG" 2>&1
    exit $?
  elif [ "\$DIR" == "/" -o "\$DIR" == "." ]; then
    echo `\date` ERROR "\$3" not under "\$DOWNLOAD". >> "\$LOG"
    exit 1
  else
    SRC=\$DIR
  fi
done
EOF

touch ${CONFIG_FOLDER:-/config}/dht.dat
touch ${CONFIG_FOLDER:-/config}/aria2.session
touch ${CONFIG_FOLDER:-/config}/aria2.input
touch ${CONFIG_FOLDER:-/config}/dht6.dat
${CONFIG_FOLDER:-/config}/cookies.dat
exec "$@"
