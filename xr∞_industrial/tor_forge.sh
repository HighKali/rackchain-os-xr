#!/bin/bash
# governor_forge.sh — Eleva nodo a governatore XR∞

set -e
NODE_ID="$1"
UPTIME=$(cat ~/eco_log.py | grep "$NODE_ID" | wc -l)
BOINC_CREDIT=$(cat ~/boinc_log.txt | grep "$NODE_ID" | awk '{print $NF}')

if [[ "$UPTIME" -ge 99 && "$BOINC_CREDIT" -ge 1000 ]]; then
  echo "👑 Nodo $NODE_ID elevato a governatore"
  echo "$(date) — $NODE_ID → GOVERNATORE" >> ~/eco_log.py
  curl -s -X POST https://rackchain.xr/api/governor/elevate \
    -H "Authorization: Bearer <XR∞TOKEN>" \
    -d "node_id=$NODE_ID&role=governor"
else
  echo "❌ Nodo $NODE_ID non idoneo: uptime=$UPTIME%, BOINC=$BOINC_CREDIT"
fi
