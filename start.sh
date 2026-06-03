#!/usr/bin/env bash
set -euo pipefail
# Check if containers are already running; start only if needed
if ! docker ps --filter "name=blog_webserver" --format '{{.Names}}' | grep -q blog_webserver || \
   ! docker ps --filter "name=blog_database" --format '{{.Names}}' | grep -q blog_database; then
  printf "\nStarting Docker Compose...\n"
  docker compose up -d
else
  printf "\nContainers already running, skipping docker compose.\n"
fi

# Wait for containers to be healthy/running
printf "\nWaiting for containers to start...\n"
for i in {1..30}; do
  if docker ps --filter "status=running" | grep -q "blog_webserver" && \
     docker ps --filter "status=running" | grep -q "blog_database"; then
    printf "Containers are running.\n"
    break
  fi
  sleep 2
done

# Install Composer dependencies inside webserver container
printf "\nInstalling Composer dependencies...\n"
docker exec -it -w /var/www/html blog_webserver composer install --no-interaction --prefer-dist

# Import database via Composer script
printf "\nImporting database...\n"
docker exec -i blog_database mysql -hlocalhost -udocker -pdocker docker < blog.sql

# Set permissions for cache directory
printf "\nSetting cache folder permissions...\n"
chmod 775 ./cache

printf "\nAll tasks completed successfully.\n"
printf "\n"
printf "\nOpen http://localhost:8090 in your browser.\n"
