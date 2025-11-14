#!/data/data/com.termux/files/usr/bin/bash

# 📦 INSTALLA PACCHETTI
pkg update -y && pkg upgrade -y
pkg install curl jq nano python git -y
pip install flask requests

# 📁 CREA LA CARTELLA
mkdir -p ~/rackchain-os-xr/xr_industrial
cd ~/rackchain-os-xr/xr_industrial

# 🔑 CHIAVE API SIMBOLICA
API_KEY_1LINK="xr∞_api_1link_ABC123XYZ"

# 📜 CREA IL FILE JSON
cat > sigillo_index.json <<EOF
{
  "wallet": "XrjAKc...",
  "balance": 5555.12,
  "seed": "twelvetoprepareddlakesuddenlywesterneaten",
  "badge": "https://highkali.github.io/rackchain-os-xr/xr_badge.svg",
  "qr": "https://highkali.github.io/rackchain-os-xr/xr_wallet_qr.svg",
  "api_key": "$API_KEY_1LINK"
}
EOF

# 🔮 SYNC LOCALE
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

# 🌐 TEST DNS
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

# 🌠 SITO HTML CON SWAP
cat > sigillo_orbitale.html <<EOF
<!DOCTYPE html>
<html><head><title>XR∞Coin</title></head><body style="background:#0b0f2b;color:#fff;font-family:Georgia">
<h1 style="color:gold;text-align:center">XR∞Coin — Sigillo Orbitante</h1>
<p style="text-align:center">Wallet: XrjAKc... — Balance: $5555.12 $DSN</p>
<img src="xr_wallet_qr.svg" width="220"><br>
<img src="xr_badge.svg" width="320">
<h2 style="color:gold">💧 Swap & Liquid Pool</h2>
<ul>
  <li><a href="/sigillo_swap.html">🔄 Esegui uno swap</a></li>
  <li><a href="/sigillo_pool.html">🧪 Crea una liquid pool</a></li>
</ul>
</body></html>
EOF

# 🔄 MODULO SWAP
cat > sigillo_swap.html <<EOF
<!DOCTYPE html>
<html><head><title>Swap XR∞Coin</title></head><body style="background:#0b0f2b;color:#fff;font-family:Georgia">
<h1 style="color:gold;text-align:center">🔄 Swap XR∞Coin ↔ $DSN</h1>
<form method="POST" action="https://rackchain.io/api/swap?key=$API_KEY_1LINK">
  <label>Indirizzo XR∞Coin:</label><br>
  <input type="text" name="xr_address"><br><br>
  <label>Importo da scambiare:</label><br>
  <input type="number" name="amount"><br><br>
  <label>Destinazione $DSN:</label><br>
  <input type="text" name="dsn_address"><br><br>
  <input type="submit" value="Esegui Swap">
</form>
</body></html>
EOF

# 🧪 MODULO POOL
cat > sigillo_pool.html <<EOF
<!DOCTYPE html>
<html><head><title>Crea Liquid Pool</title></head><body style="background:#0b0f2b;color:#fff;font-family:Georgia">
<h1 style="color:gold;text-align:center">🧪 Crea una Liquid Pool</h1>
<form method="POST" action="https://rackchain.io/api/create_pool?key=$API_KEY_1LINK">
  <label>Nome della pool:</label><br>
  <input type="text" name="pool_name"><br><br>
  <label>Indirizzo XR∞Coin:</label><br>
  <input type="text" name="xr_address"><br><br>
  <label>Importo iniziale:</label><br>
  <input type="number" name="initial_amount"><br><br>
  <input type="submit" value="Crea Pool">
</form>
</body></html>
EOF

# 🔧 SERVER FLASK
cat > sigillo_index.py <<EOF
from flask import Flask, jsonify, send_from_directory
import json
app = Flask(__name__)
@app.route("/sigillo")
def sigillo():
    with open("sigillo_index.json") as f:
        return jsonify(json.load(f))
@app.route("/badge")
def badge():
    return send_from_directory(".", "xr_badge.svg")
app.run(host="0.0.0.0", port=5000)
EOF

# 🚀 ESECUZIONE RITUALE
python sigillo_sync_local.py
./sigillo_dns_test.sh
nohup python sigillo_index.py &
nohup python -m http.server 8080 &

echo "✅ Tutto creato, testato e servito. Il nodo è orbitante, il sito è attivo, la pool è pronta."
