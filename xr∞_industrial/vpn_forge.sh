#!/bin/bash
# vpn_forge.sh — Nodo VPN con badge e QR

set -e
DIR="$HOME/xr∞_vpn_nodes"
mkdir -p "$DIR"
cd "$DIR"

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

python3 ~/rackchain-os-xr/xr∞_industrial/generate_qr.py "$(cat client.conf)"
zip -r vpn_package.zip . > /dev/null
echo "$(date) — VPN generata in $DIR" >> ~/eco_log.py
