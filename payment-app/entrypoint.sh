#!/bin/bash
set -e

# Remove a potentially pre-existing server.pid for Rails.
rm -f /payment-app/tmp/pids/server.pid

# Wait for postgres to boot up
until psql "${DATABASE_URL}" -c '\q'; do
  >&2 echo "Postgres is unavailable - sleeping"
  sleep 1
done

>&2 echo "Postgres is up - executing command"

if psql "${DATABASE_URL}/demo_app_development" -c '\q'
then
    echo "database exists!"
else
    echo "Datase does is not present. Will setup and migrate"
    bundle exec rails db:setup && bundle exec rails db:migrate
fi

echo "Install node packages"
yarn install --pure-lockfile

echo "Pre-compile assets"
bundle exec rails assets:precompile
  


# Then exec the container's main process (what's set as CMD in the Dockerfile).
exec "$@"
