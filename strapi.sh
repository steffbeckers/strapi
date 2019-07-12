#!/bin/sh
set -ea

_stopStrapi() {
  echo "Stopping strapi"
  kill -SIGINT "$strapiPID"
  wait "$strapiPID"
}

trap _stopStrapi SIGTERM SIGINT

cd /usr/src/api

NODE_ENV=${NODE_ENV:-production}
APP_NAME=${APP_NAME:-strapi-app}
DATABASE_CLIENT=${DATABASE_CLIENT:-mongo}
DATABASE_HOST=${DATABASE_HOST:-mongodb}
DATABASE_PORT=${DATABASE_PORT:-27017}
DATABASE_NAME=${DATABASE_NAME:-strapi}
DATABASE_USERNAME=${DATABASE_USERNAME:-strapi}
DATABASE_PASSWORD=${DATABASE_PASSWORD:-3IDAcHdrRmwxWhAkNU6P}
DATABASE_SSL=${DATABASE_SSL:-false}
DATABASE_AUTHENTICATION_DATABASE=${DATABASE_AUTHENTICATION_DATABASE:-strapi}
EXTRA_ARGS=${EXTRA_ARGS:-}

if [ ! -f "$APP_NAME/package.json" ]
then
    strapi new ${APP_NAME} --dbclient=$DATABASE_CLIENT --dbhost=$DATABASE_HOST --dbport=$DATABASE_PORT --dbname=$DATABASE_NAME --dbusername=$DATABASE_USERNAME --dbpassword=$DATABASE_PASSWORD --dbssl=$DATABASE_SSL --dbauth=$DATABASE_AUTHENTICATION_DATABASE $EXTRA_ARGS
elif [ ! -d "$APP_NAME/node_modules" ]
then
    npm install --prefix ./$APP_NAME
fi

cd $APP_NAME
strapi start &

strapiPID=$!
wait "$strapiPID"
