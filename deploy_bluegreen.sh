#!/bin/bash
set -e

TAG=${1:-latest}
export TAG

echo "Deploying green with tag $TAG..."

# Start green containers
docker compose -f docker-compose.yml up -d backend_green frontend_green

# Wait for backend to be ready
echo "Waiting for backend_green to be healthy..."
until curl -s http://backend_green:8000/health; do
    echo "Still waiting..."
    sleep 2
done

# Switch Nginx to green
docker exec todo_nginx nginx -s reload

echo "Deployment complete!"


