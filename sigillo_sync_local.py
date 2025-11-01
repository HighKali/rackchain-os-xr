import json, datetime
with open("sigillo_index.json") as f: data = json.load(f)
entry = {
  "azione": "sync_wallet",
  "timestamp": datetime.datetime.now().isoformat(),
  "firma": "🪐 Sincronizzato sotto l’orbita di Saturno",
  "dati": data
}
with open("sigillo_libro.json") as f: libro = json.load(f)
libro.append(entry)
with open("sigillo_libro.json", "w") as f: json.dump(libro, f, indent=2)
print("✅ Wallet sincronizzato e firmato nel libro dei sigilli.")
