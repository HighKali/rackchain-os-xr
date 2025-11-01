#!/bin/bash
# xr∞_forge.sh — Forgiatore universale XR∞ Industrial Constellation

set -e

NODE_TYPE=${1:-vpn}
NODE_ID="$(hostname)-$(date +%s)"
DIR="$HOME/xr∞_nodes/$NODE_ID"
mkdir -p "$DIR"
cd "$DIR"

# === Configurazione ===
if [[ "$NODE_TYPE" == "vpn" ]]; then
  wg genkey | tee privatekey | wg pubkey > publickey
  cat > client.conf <<EOF
[Interface]
PrivateKey = $(cat privatekey)
Address = 10.0.0.2/24
DNS = 1.1.1.1

[Peer]
PublicKey = <SERVER_PUBLIC_KEY>
Endpoint = <SERVER_IP>:51820
AllowedIPs = 0.0.0.0/0
PersistentKeepalive = 25
EOF
  QR_DATA=$(cat client.conf)
else
  tor --quiet --hash-password "torpass" > tor_hash.txt
  echo "Bridge tor://$NODE_ID" > tor_bridge.txt
  QR_DATA=$(cat tor_bridge.txt)
fi

# === QR rituale ===
python3 ~/rackchain-os-xr/xr∞_industrial/generate_qr.py "$QR_DATA"

# === Sigillo SVG ===
cat > badge.svg <<EOF
<svg xmlns="http://www.w3.org/2000/svg" width="300" height="100">
  <rect width="100%" height="100%" fill="#0a0a0a"/>
  <text x="50%" y="50%" fill="#00ffcc" font-size="16" font-family="monospace" dominant-baseline="middle" text-anchor="middle">
    XR∞ NODE: $NODE_ID
  </text>
</svg>
EOF

# === Manifesto SVG ===
cat > manifesto.svg <<EOF
<svg xmlns="http://www.w3.org/2000/svg" width="400" height="150">
  <rect width="100%" height="100%" fill="#0f0f0f"/>
  <text x="50%" y="40%" fill="#ffcc00" font-size="14" font-family="monospace" dominant-baseline="middle" text-anchor="middle">
    XR∞ Industrial Constellation
  </text>
  <text x="50%" y="60%" fill="#ffffff" font-size="12" font-family="monospace" dominant-baseline="middle" text-anchor="middle">
    Nodo: $NODE_ID — Tipo: $NODE_TYPE
  </text>
</svg>
EOF

# === Packaging ZIP ===
zip -r "$NODE_ID.zip" . > /dev/null

# === Logging ===
echo "$(date) — Nodo $NODE_ID ($NODE_TYPE) immortalizzato" >> ~/rackchain-os-xr/xr∞_industrial/eco_log.txt

# === Notifica Telegram ===
curl -s -X POST "https://api.telegram.org/bot<API_KEY>/sendMessage" \
  -d chat_id="<CHAT_ID>" \
  -d text="🧿 Nodo $NODE_ID ($NODE_TYPE) registrato e sigillato"

# === Registrazione su /node/receive ===
curl -s -X POST https://rackchain.xr/api/node/receive \
  -H "Authorization: Bearer <XR∞TOKEN>" \
  -F "node_type=$NODE_TYPE" \
  -F "sigillo=$NODE_ID" \
  -F "eco_log=$(date)" \
  -F "package=@$NODE_ID.zip"

echo "✅ Nodo $NODE_ID completato e distribuito"
