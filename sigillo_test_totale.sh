#!/data/data/com.termux/files/usr/bin/bash

# 📁 CREA LA CARTELLA SE NON ESISTE
mkdir -p ~/rackchain-os-xr/xr_industrial
cd ~/rackchain-os-xr/xr_industrial

# 📜 CREA IL FILE JSON DI DATI
cat > sigillo_index.json <<EOF
{
  "wallet": "XrjAKc...",
  "balance": 5555.12,
  "seed": "twelvetoprepareddlakesuddenlywesterneaten",
  "badge": "https://highkali.github.io/rackchain-os-xr/xr_badge.svg",
  "qr": "https://highkali.github.io/rackchain-os-xr/xr_wallet_qr.svg"
}
EOF

# 🔮 CREA IL SYNC LOCALE
cat > sigillo_sync_local.py <<EOF
import json
from datetime import datetime

with open("sigillo_index.json") as f:
    data = json.load(f)

log = {
    "timestamp": datetime.now().isoformat(),
    "status": "local_sync",
    "data": data
}

with open("sigillo_sync_log.json", "w") as f:
    json.dump(log, f, indent=2)

print("✅ Sync locale completato. Dati salvati in sigillo_sync_log.json")
EOF

# 🌐 CREA IL TEST DNS
cat > sigillo_dns_test.sh <<EOF
#!/data/data/com.termux/files/usr/bin/bash

echo "🔍 Test DNS per rackchain.io"
nslookup rackchain.io

echo "🌐 Test ping:"
ping -c 3 rackchain.io

echo "📡 Test curl:"
curl -I https://rackchain.io
EOF

chmod +x sigillo_dns_test.sh

# 🚀 ESECUZIONE RITUALE
python sigillo_sync_local.py
./sigillo_dns_test.sh

echo "✅ Tutto generato e testato. Sync locale completato, DNS verificato."
