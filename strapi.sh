#!/bin/sh
set -ea

_stopStrapi() {
  echo "Stopping strapi"
  kill -INT "$strapiPID"
  wait "$strapiPID"
}

trap _stopStrapi TERM INT

cd /app

strapi start &

strapiPID=$!
wait "$strapiPID"
