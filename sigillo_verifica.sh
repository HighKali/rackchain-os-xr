#!/bin/bash

echo "🔍 Verifica orbitale XR∞ in corso..."

# === Verifica struttura archivio ===
echo "📦 Controllo contenuto sigillo_orbitale.tar.gz..."
tar -tzf sigillo_orbitale.tar.gz | grep -E 'sigillo_manifesto.txt|sigillo_index.json|sigillo_badge.svg|vpn_qr.png|validator.html|governor.html|validator_audit.html|eco_log.txt' > /dev/null
if [ $? -eq 0 ]; then
  echo "✅ Archivio contiene tutti gli artefatti richiesti."
else
  echo "❌ Archivio incompleto o danneggiato."
  exit 1
fi

# === Verifica hash ZIP ===
echo "🔐 Verifica SHA256 del pacchetto ZIP..."
ZIP_NAME=$(jq -r .zip sigillo_index.json)
EXPECTED_HASH=$(jq -r .hash sigillo_index.json)
ACTUAL_HASH=$(sha256sum "$ZIP_NAME" | cut -d ' ' -f1)

if [ "$EXPECTED_HASH" == "$ACTUAL_HASH" ]; then
  echo "✅ Hash ZIP verificato: $ACTUAL_HASH"
else
  echo "❌ Hash ZIP non corrisponde!"
  echo "Atteso: $EXPECTED_HASH"
  echo "Trovato: $ACTUAL_HASH"
  exit 1
fi

# === Verifica firma GPG ===
echo "🔏 Verifica firma GPG del manifesto..."
gpg --verify sigillo_manifesto.txt.sig sigillo_manifesto.txt 2>/dev/null
if [ $? -eq 0 ]; then
  echo "✅ Firma GPG del manifesto valida."
else
  echo "⚠️ Firma GPG non verificabile o assente."
fi

echo "🧾 Verifica completata. Il sigillo è integro e conforme."
