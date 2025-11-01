#!/bin/bash

# === Parametri del nodo ===
API_KEY="xr∞_node_001"
API_SECRET="orbita_segreta_∞"
RECEIVE_URL="http://localhost:5000/node/receive"

# === Autenticazione via API ===
echo "🔐 Autenticazione in corso..."
curl -s -X POST "$RECEIVE_URL" \
  -H "Content-Type: application/json" \
  -d "{\"api_key\":\"$API_KEY\",\"api_secret\":\"$API_SECRET\"}"

# === Packaging ZIP ===
ZIP_NAME="sigillo_$(date +%Y%m%d_%H%M%S).zip"
echo "📦 Creazione pacchetto: $ZIP_NAME"
zip -r "$ZIP_NAME" . -x "*.zip" "*.png" "*.txt"

# === Notifica Matrix all'avvio ===
echo "📣 Notifica Matrix: avvio nodo"
python3 sigillo_matrix.py "🌀 Nodo avviato: $ZIP_NAME"

# === Generazione QR ===
echo "🖼️ Generazione QR"
python3 generate_qr.py
echo "✅ QR generato: vpn_qr.png"

# === Sigillo orbitale + Manifesto ===
echo "🧿 Generazione sigillo orbitale + manifesto"
python3 -c "from sigillo_index import genera_sigillo; genera_sigillo(\"$API_KEY\", \"$ZIP_NAME\")"

# === Badge SVG orbitale ===
HASH=$(sha256sum "$ZIP_NAME" | cut -d ' ' -f1)
echo "🎨 Generazione badge SVG"
python3 -c "from generate_badge import genera_badge_svg; genera_badge_svg(\"$API_KEY\", \"$HASH\")"

# === Logging Git ===
COMMIT_HASH=$(git rev-parse HEAD)
echo "[🧾 Commit Git] $(date) $COMMIT_HASH" >> eco_log.txt

# === Notifica Matrix del push ===
echo "📤 Notifica Matrix: push Git"
python3 sigillo_matrix.py "📤 Push Git: $COMMIT_HASH"

# === Sanificazione codice ===
echo "🧹 Sanificazione codice"
find . -name "*.pyc" -delete
find . -name "__pycache__" -type d -exec rm -r {} +
find . -name "*.zip" -type f -delete

# === Aggiornamento GitHub ===
echo "🔄 Aggiornamento GitHub"
git add .
git commit -m "🧼 Sanificazione XR∞ Industrial: pulizia, aggiornamento, immortalizzazione"
git push origin main

# === Logging sanificazione ===
COMMIT_HASH=$(git rev-parse HEAD)
echo "[🧼 Sanificazione Git] $(date) $COMMIT_HASH" >> eco_log.txt
python3 sigillo_matrix.py "🧼 Codice sanificato e pushato: $COMMIT_HASH"

echo "✅ Sigillo totale completato e immortalizzato: $ZIP_NAME"
