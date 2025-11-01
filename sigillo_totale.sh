#!/bin/bash

API_KEY="xr∞_node_001"
API_SECRET="orbita_segreta_∞"
RECEIVE_URL="http://localhost:5000/node/receive"

echo "🔐 Autenticazione in corso..."
curl -s -X POST "$RECEIVE_URL" \
  -H "Content-Type: application/json" \
  -d "{\"api_key\":\"$API_KEY\",\"api_secret\":\"$API_SECRET\"}"

ZIP_NAME="sigillo_$(date +%Y%m%d_%H%M%S).zip"
echo "📦 Creazione pacchetto: $ZIP_NAME"
zip -r "$ZIP_NAME" . -x "*.zip" "*.png" "*.txt"

echo "📣 Notifica Matrix: avvio nodo"
python3 sigillo_matrix.py "🌀 Nodo avviato: $ZIP_NAME"

echo "🖼️ Generazione QR"
python3 generate_qr.py
echo "✅ QR generato: vpn_qr.png"

echo "🧿 Generazione sigillo orbitale + manifesto"
python3 -c "from sigillo_index import genera_sigillo; genera_sigillo(\"$API_KEY\", \"$ZIP_NAME\")"

HASH=$(sha256sum "$ZIP_NAME" | cut -d ' ' -f1)
echo "🎨 Generazione badge SVG"
python3 -c "from generate_badge import genera_badge_svg; genera_badge_svg(\"$API_KEY\", \"$HASH\")"

COMMIT_HASH=$(git rev-parse HEAD)
echo "[🧾 Commit Git] $(date) $COMMIT_HASH" >> eco_log.txt
echo "📤 Notifica Matrix: push Git"
python3 sigillo_matrix.py "📤 Push Git: $COMMIT_HASH"

echo "✅ Sigillo totale completato: $ZIP_NAME"
