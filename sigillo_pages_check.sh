#!/data/data/com.termux/files/usr/bin/bash

# 🌐 URL del sito orbitante
SITE_URL="https://highkali.github.io/rackchain-os-xr/index.html"

# 📁 Output del badge
BADGE_FILE="sigillo_status.svg"

# 🔍 Verifica accessibilità
echo "🔍 Verifico lo stato del nodo orbitale..."
STATUS_CODE=$(curl -s -o /dev/null -w "%{http_code}" "$SITE_URL")

# 🎨 Genera badge SVG
if [ "$STATUS_CODE" -eq 200 ]; then
    echo "🟢 Nodo attivo — codice 200"
    cat > "$BADGE_FILE" <<EOF
<svg xmlns="http://www.w3.org/2000/svg" width="220" height="60">
  <rect width="220" height="60" fill="#0b0f2b"/>
  <text x="20" y="35" font-size="20" fill="gold">🔮 Nodo orbitale XR∞Coin</text>
  <circle cx="200" cy="30" r="10" fill="lime"/>
</svg>
EOF
else
    echo "🔴 Nodo spento — codice $STATUS_CODE"
    cat > "$BADGE_FILE" <<EOF
<svg xmlns="http://www.w3.org/2000/svg" width="220" height="60">
  <rect width="220" height="60" fill="#0b0f2b"/>
  <text x="20" y="35" font-size="20" fill="gold">🔮 Nodo orbitale XR∞Coin</text>
  <circle cx="200" cy="30" r="10" fill="red"/>
</svg>
EOF
fi

# 📦 Output finale
echo "📦 Badge generato: $BADGE_FILE"
