#!/bin/sh
echo "Letsencrypt renewal hook running..."
echo "RENEWED_DOMAINS=$RENEWED_DOMAINS"
echo "RENEWED_LINEAGE=$RENEWED_LINEAGE"

tgdomain="figlive.nsocket.com"
destpath="/home/eda/livejack/proxy/nginx/ssl/cert/figlive.nsocket.com"
destuser="eda"

if grep --quiet "${tgdomain}" <<< "$RENEWED_DOMAINS"; then
  cp -f $RENEWED_LINEAGE/*.pem ${destpath}/
  chown ${destuser}:${destuser} ${destpath}/*
fi

