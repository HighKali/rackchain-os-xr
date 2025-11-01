#!/bin/bash

API_KEY="xr∞_node_001"
API_SECRET="orbita_segreta_∞"
RECEIVE_URL="http://localhost:5000/node/receive"

curl -X POST "$RECEIVE_URL" \
  -H "Content-Type: application/json" \
  -d '{"api_key":"'"$API_KEY"'","api_secret":"'"$API_SECRET"'"}'
