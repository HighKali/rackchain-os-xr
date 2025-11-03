#!/bin/bash
# governor_forge.sh — Elevazione rituale a governatore XR∞

set -e

NODE_ID=${1:-vpn-001}
DIR="$HOME/xr∞_nodes/$NODE_ID"
mkdir -p "$DIR"
cd "$DIR"

# === Audit rituale ===
python3 ~/rackchain-os-xr/xr∞_industrial/governor_audit.py "$NODE_ID" || {
  echo "❌ Audit fallito: nodo non idoneo come governatore"
  exit 1
}

# === Sigillo SVG ===
cat > badge_governor.svg <<EOF
<svg xmlns="http://www.w3.org/2000/svg" width="300" height="100">
  <rect width="100%" height="100%" fill="#0f0f0f"/>
  <text x="50%" y="50%" fill="#ffcc00" font-size="16" font-family="monospace" dominant-baseline="middle" text-anchor="middle">
    GOVERNATORE XR∞: $NODE_ID
  </text>
</svg>
EOF

# === Manifesto SVG ===
cat > manifesto_governor.svg <<EOF
<svg xmlns="http://www.w3.org/2000/svg" width="400" height="150">
  <rect width="100%" height="100%" fill="#1a1a1a"/>
  <text x="50%" y="40%" fill="#ffffff" font-size="14" font-family="monospace" dominant-baseline="middle" text-anchor="middle">
    XR∞ Industrial Constellation
  </text>
  <text x="50%" y="60%" fill="#ffcc00" font-size="12" font-family="monospace" dominant-baseline="middle" text-anchor="middle">
    GOVERNATORE: $NODE_ID — Sigillo Sovrano
  </text>
</svg>
EOF

# === QR rituale ===
python3 ~/rackchain-os-xr/xr∞_industrial/generate_qr.py "GOVERNATORE XR∞: $NODE_ID"

# === Packaging ZIP ===
zip -r "$NODE_ID-governor.zip" . > /dev/null

# === Logging ===
echo "$(date) — Nodo $NODE_ID elevato a GOVERNATORE XR∞" >> ~/rackchain-os-xr/xr∞_industrial/eco_log.txt

# === Notifica Telegram ===
curl -s -X POST "https://api.telegram.org/bot<API_KEY>/sendMessage" \
  -d chat_id="<CHAT_ID>" \
  -d text="👑 Nodo $NODE_ID elevato a GOVERNATORE XR∞ e sigillato"

# === Registrazione su /node/receive ===
curl -s -X POST https://rackchain.xr/api/node/receive \
  -H "Authorization: Bearer <XR∞TOKEN>" \
  -F "node_type=governor" \
  -F "sigillo=$NODE_ID" \
  -F "eco_log=$(date)" \
  -F "package=@$NODE_ID-governor.zip"

echo "✅ Elevazione completata: $NODE_ID è ora GOVERNATORE XR∞"
