# custode_forge.py — Onboarding e immortalizzazione XR∞ Industrial Constellation

import os
import zipfile
import datetime
import requests
import qrcode

NODE_TYPE = "vpn"  # oppure "tor"
NODE_ID = f"{os.uname().nodename}-{int(datetime.datetime.now().timestamp())}"
DIR = os.path.expanduser(f"~/xr∞_nodes/{NODE_ID}")
os.makedirs(DIR, exist_ok=True)
os.chdir(DIR)

# === Configurazione nodo ===
if NODE_TYPE == "vpn":
    os.system("wg genkey | tee privatekey | wg pubkey > publickey")
    with open("client.conf", "w") as f:
        f.write(f"""[Interface]
PrivateKey = {open("privatekey").read().strip()}
Address = 10.0.0.2/24
DNS = 1.1.1.1

[Peer]
PublicKey = <SERVER_PUBLIC_KEY>
Endpoint = <SERVER_IP>:51820
AllowedIPs = 0.0.0.0/0
PersistentKeepalive = 25
""")
    qr_data = open("client.conf").read()
else:
    os.system("tor --quiet --hash-password 'torpass' > tor_hash.txt")
    with open("tor_bridge.txt", "w") as f:
        f.write(f"Bridge tor://{NODE_ID}")
    qr_data = open("tor_bridge.txt").read()

# === QR rituale ===
img = qrcode.make(qr_data)
img.save("qr.png")

# === Sigillo SVG ===
with open("badge.svg", "w") as f:
    f.write(f"""<svg xmlns="http://www.w3.org/2000/svg" width="300" height="100">
  <rect width="100%" height="100%" fill="#0a0a0a"/>
  <text x="50%" y="50%" fill="#00ffcc" font-size="16" font-family="monospace" dominant-baseline="middle" text-anchor="middle">
    XR∞ NODE: {NODE_ID}
  </text>
</svg>""")

# === Manifesto SVG ===
with open("manifesto.svg", "w") as f:
    f.write(f"""<svg xmlns="http://www.w3.org/2000/svg" width="400" height="150">
  <rect width="100%" height="100%" fill="#0f0f0f"/>
  <text x="50%" y="40%" fill="#ffcc00" font-size="14" font-family="monospace" dominant-baseline="middle" text-anchor="middle">
    XR∞ Industrial Constellation
  </text>
  <text x="50%" y="60%" fill="#ffffff" font-size="12" font-family="monospace" dominant-baseline="middle" text-anchor="middle">
    Nodo: {NODE_ID} — Tipo: {NODE_TYPE}
  </text>
</svg>""")

# === Packaging ZIP ===
with zipfile.ZipFile(f"{NODE_ID}.zip", "w") as zipf:
    for file in os.listdir(DIR):
        zipf.write(file)

# === Logging ===
with open(os.path.expanduser("~/rackchain-os-xr/xr∞_industrial/eco_log.txt"), "a") as log:
    log.write(f"{datetime.datetime.now()} — Nodo {NODE_ID} ({NODE_TYPE}) immortalizzato\n")

# === Notifica Telegram ===
requests.post("https://api.telegram.org/bot<API_KEY>/sendMessage", data={
    "chat_id": "<CHAT_ID>",
    "text": f"🧿 Nodo {NODE_ID} ({NODE_TYPE}) registrato e sigillato"
})

# === Registrazione su /node/receive ===
with open(f"{NODE_ID}.zip", "rb") as pkg:
    requests.post("https://rackchain.xr/api/node/receive", headers={
        "Authorization": "Bearer <XR∞TOKEN>"
    }, files={
        "package": pkg
    }, data={
        "node_type": NODE_TYPE,
        "sigillo": NODE_ID,
        "eco_log": str(datetime.datetime.now())
    })

print(f"✅ Nodo {NODE_ID} completato e distribuito")
