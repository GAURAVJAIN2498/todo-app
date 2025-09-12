#!/bin/bash
set -e
TAG=$1
STATE_FILE=".current_color"
NGINX_DIR="./nginx"

if [ -f "$STATE_FILE" ]; then
  CURRENT=$(cat $STATE_FILE)
else
  CURRENT="blue"
fi

if [ "$CURRENT" = "blue" ]; then
  NEW="green"
else
  NEW="blue"
fi

echo "Deploying $NEW with tag $TAG"

export TAG=$TAG
docker-compose -f docker-compose.prod.yml up -d backend_${NEW} frontend_${NEW}

# health check
sleep 5
curl -f http://localhost:8000/api/todos/ || { echo "Health check failed"; exit 1; }

cp $NGINX_DIR/nginx.${NEW}.conf $NGINX_DIR/default.conf
docker exec todo_nginx nginx -s reload

docker-compose -f docker-compose.prod.yml stop backend_${CURRENT} frontend_${CURRENT}
echo $NEW > $STATE_FILE

echo "Deployment complete -> Active: $NEW"

