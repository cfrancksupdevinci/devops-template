#!/bin/bash
# Script to verify deployment

URL="http://localhost:8080"

echo "Verifying deployment at $URL..."
STATUS_CODE=$(curl -o /dev/null -s -w "%{http_code}" $URL)

if [ "$STATUS_CODE" -eq 200 ]; then
  echo "Deployment verification successful! Status code: $STATUS_CODE"
else
  echo "Deployment verification failed. Status code: $STATUS_CODE"
fi