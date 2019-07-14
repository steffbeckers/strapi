#!/bin/sh
set -ea

_stopStrapi() {
  echo "Stopping strapi"
  kill -INT "$strapiPID"
  wait "$strapiPID"
}

trap _stopStrapi TERM INT

cd /app

if [ ! -d "node_modules" ]
then
  npm install
fi

strapi start &

strapiPID=$!
wait "$strapiPID"
