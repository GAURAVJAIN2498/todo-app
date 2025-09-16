#!/bin/bash
set -e

TAG=${1:-latest}
export TAG

COLOR=green   # or detect dynamically
OLD_COLOR=blue

echo "Deploying $COLOR with tag $TAG..."

# Make sure db + nginx are running
docker compose -f docker-compose.yml up -d db nginx

# Start new color containers
docker compose -f docker-compose.yml up -d backend_${COLOR} frontend_${COLOR}

# Wait for backend to be healthy
echo "Waiting for backend_${COLOR} to be healthy..."
until curl -s http://backend_${COLOR}:8000/health; do
    echo "Still waiting..."
    sleep 2
done

# Switch nginx config to point to new color
docker cp nginx.${COLOR}.conf todo_nginx:/etc/nginx/conf.d/default.conf
docker exec todo_nginx nginx -s reload

echo "Nginx switched to $COLOR."

# Stop old color containers
echo "Stopping $OLD_COLOR containers..."
docker compose -f docker-compose.yml stop backend_${OLD_COLOR} frontend_${OLD_COLOR}

echo "Deployment complete! Active color: $COLOR"
