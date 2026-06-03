#!/usr/bin/env bash
set -euo pipefail
# Start services in detached mode
printf "\nStarting Docker Compose...\n"
docker compose up -d

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
docker exec -it -w /var/www/html blog_webserver composer run db:import

printf "\nAll tasks completed successfully.\n"
