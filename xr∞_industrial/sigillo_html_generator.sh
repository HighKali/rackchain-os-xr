#!/bin/bash

COMMIT=$(jq -r .commit sigillo_index.json)
HASH=$(jq -r .hash sigillo_index.json)

# === validator.html ===
cat <<EOF > validator.html
<!DOCTYPE html>
<html><head><meta charset="UTF-8"><title>Validator Orbitale XR∞</title>
<style>body{background:#0f0f0f;color:#e0e0e0;font-family:monospace;padding:20px}
img{max-width:300px;margin:10px 0}pre{background:#1a1a1a;padding:10px;border-radius:5px}</style></head>
<body><h1>Validator Orbitale XR∞</h1>
<h2>🎨 Badge Orbitale</h2><img src="sigillo_badge.svg" alt="Badge Orbitale">
<h2>🖼️ QR del Nodo</h2><img src="vpn_qr.png" alt="QR Nodo">
<h2>📜 Manifesto Orbitale</h2><pre>$(cat sigillo_manifesto.txt)</pre>
<h2>🔗 Commit Git</h2><pre>$COMMIT</pre>
</body></html>
EOF

# === governor.html ===
cat <<EOF > governor.html
<!DOCTYPE html>
<html><head><meta charset="UTF-8"><title>Governatore Orbitale XR∞</title>
<style>body{background:#0f0f0f;color:#e0e0e0;font-family:monospace;padding:20px}
pre{background:#1a1a1a;padding:10px;border-radius:5px}</style></head>
<body><h1>Governatore Orbitale XR∞</h1>
<h2>🎨 Badge Orbitale</h2><img src="sigillo_badge.svg" alt="Badge Orbitale">
<h2>📜 Manifesto Orbitale</h2><pre>$(cat sigillo_manifesto.txt)</pre>
<h2>📘 Policy di Governance</h2><pre>$(cat governor_policy.txt)</pre>
<h2>🔗 Commit Git</h2><pre>$COMMIT</pre>
</body></html>
EOF

# === validator_audit.html ===
cat <<EOF > validator_audit.html
<!DOCTYPE html>
<html><head><meta charset="UTF-8"><title>Audit Orbitale XR∞</title>
<style>body{background:#0f0f0f;color:#e0e0e0;font-family:monospace;padding:20px}
pre{background:#1a1a1a;padding:10px;border-radius:5px}</style></head>
<body><h1>Audit Orbitale XR∞</h1>
<h2>🔐 SHA256 del pacchetto ZIP</h2><pre>$HASH</pre>
<h2>🔗 Commit Git</h2><pre>$COMMIT</pre>
<h2>🧾 Log Orbitale</h2><pre>$(cat eco_log.txt)</pre>
<h2>🧿 Firma Orbitale</h2><pre>🧿 Firmato dal Custode Orbitale</pre>
</body></html>
EOF

echo "✅ Pagine HTML orbitali generate: validator.html, governor.html, validator_audit.html"
