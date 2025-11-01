#!/bin/bash
# eco_launch.sh — Orchestratore XR∞ Industrial Constellation

set -e
NODE_TYPE=${1:-vpn}
DIR="$HOME/xr∞_nodes/$NODE_TYPE"
mkdir -p "$DIR"
cd "$DIR"

# === Generazione ===
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
elif [[ "$NODE_TYPE" == "tor" ]]; then
  tor --quiet --hash-password "torpass" > tor_hash.txt
  echo "Bridge tor://$(hostname)-$(date +%s)" > tor_bridge.txt
fi

# === QR via Python ===
python3 ~/rackchain-os-xr/xr∞_industrial/generate_qr.py "$(cat client.conf 2>/dev/null || cat tor_bridge.txt)"

# === Packaging ===
zip -r node_package.zip . > /dev/null

# === Logging ===
echo "$(date) — Nodo $NODE_TYPE generato in $DIR" >> ~/eco_log.py

# === Notifica Telegram ===
curl -s -X POST "https://api.telegram.org/bot<API_KEY>/sendMessage" \
  -d chat_id="<CHAT_ID>" \
  -d text="🛡️ Nodo $NODE_TYPE generato: $(hostname) — $(date)"

# === Autenticazione ===
curl -s -X POST https://rackchain.xr/api/node/receive \
  -H "Authorization: Bearer <XR∞TOKEN>" \
  -F "node_type=$NODE_TYPE" \
  -F "package=@node_package.zip"
