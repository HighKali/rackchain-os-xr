import json, datetime
badge = f"<svg height='100' width='300'><text x='10' y='50' fill='gold'>Swap XR∞ ↔  • {datetime.datetime.now().isoformat()}</text></svg>"
with open("sigillo_badge.svg", "w") as f: f.write(badge)
manifesto = f"🔄 Swap eseguito sotto l’ascendente di Mercurio il {datetime.datetime.now().isoformat()}"
with open("sigillo_manifesto.txt", "a") as f: f.write(manifesto + "\n")
with open("sigillo_libro.json") as f: libro = json.load(f)
libro.append({"azione": "swap", "timestamp": datetime.datetime.now().isoformat(), "firma": "♒ Mercurio attivo", "manifesto": manifesto})
with open("sigillo_libro.json", "w") as f: json.dump(libro, f, indent=2)
print("✅ Swap rituale completato. Badge e manifesto generati.")
