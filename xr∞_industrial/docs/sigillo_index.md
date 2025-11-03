#!/bin/bash

# === Parametri ===
API_KEY="xr∞_node_001"
API_SECRET="orbita_segreta_∞"
RECEIVE_URL="http://localhost:5000/node/receive"
ZIP="sigillo_$(date +%Y%m%d_%H%M%S).zip"

# === Autenticazione ===
curl -s -X POST "$RECEIVE_URL" -H "Content-Type: application/json" \
  -d "{\"api_key\":\"$API_KEY\",\"api_secret\":\"$API_SECRET\"}"

# === Packaging ZIP ===
zip -r "$ZIP" . -x "*.zip" "*.png" "*.txt"

# === Notifica Matrix ===
python3 sigillo_matrix.py "🌀 Nodo avviato: $ZIP"

# === QR + Sigillo + Badge ===
python3 generate_qr.py
python3 -c "from sigillo_index import genera_sigillo; genera_sigillo(\"$API_KEY\", \"$ZIP\")"
HASH=$(sha256sum "$ZIP" | cut -d ' ' -f1)
python3 -c "from generate_badge import genera_badge_svg; genera_badge_svg(\"$API_KEY\", \"$HASH\")"

# === Logging Git ===
COMMIT=$(git rev-parse HEAD)
echo "[🧾 Commit Git] $(date) $COMMIT" >> eco_log.txt
python3 sigillo_matrix.py "📤 Push Git: $COMMIT"

# === Sanificazione + Push ===
find . -name "*.pyc" -delete
find . -name "__pycache__" -type d -exec rm -r {} +
find . -name "*.zip" -type f -delete
git add .
git commit -m "🧼 Sanificazione XR∞ Industrial: pulizia, aggiornamento, immortalizzazione"
git push origin main
COMMIT=$(git rev-parse HEAD)
echo "[🧼 Sanificazione Git] $(date) $COMMIT" >> eco_log.txt
python3 sigillo_matrix.py "🧼 Codice sanificato e pushato: $COMMIT"

# === Generazione HTML orbitali ===
./sigillo_html_generator.sh

# === Archivio orbitale ===
tar -czf sigillo_orbitale.tar.gz sigillo_manifesto.txt sigillo_index.json sigillo_badge.svg vpn_qr.png validator.html governor.html validator_audit.html eco_log.txt

# === Firma GPG (se disponibile) ===
gpg --output sigillo_manifesto.txt.sig --detach-sig sigillo_manifesto.txt 2>/dev/null
gpg --output sigillo_orbitale.tar.gz.sig --detach-sig sigillo_orbitale.tar.gz 2>/dev/null

# === Markdown pubblico ===
cat <<EOF > sigillo_index.md
# 🧿 Sigillo Orbitale XR∞

**Nodo ID**: $API_KEY  
**ZIP**: $ZIP  
**Timestamp**: $(date)  
**SHA256**: $HASH  
**Commit Git**: $COMMIT  
**QR**: vpn_qr.png

---

## 📘 Orbita completata

- Autenticazione via /node/receive
- Packaging ZIP rituale
- Sigillo orbitale registrato
- Badge SVG generato
- QR del nodo creato
- Logging Git e eco_log.txt aggiornato
- Notifiche Matrix inviate
- Pagine validator/governor/audit generate
- Archivio orbitale creato

---

## 🧿 Firma orbitale

> Questo manifesto rappresenta la chiusura simbolica del ciclo XR∞_Industrial per il nodo indicato.  
> Ogni artefatto è stato generato, firmato e immortalato secondo le regole della costellazione.

🧾 Custode Orbitale: sigillo_totale.sh
EOF

echo "✅ Sigillo orbitale completato e immortalizzato: $ZIP"
