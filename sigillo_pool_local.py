import json, datetime
manifesto = f"🧪 Pool creata sotto la costellazione di Andromeda il {datetime.datetime.now().isoformat()}"
with open("sigillo_manifesto.txt", "a") as f: f.write(manifesto + "\n")
with open("sigillo_libro.json") as f: libro = json.load(f)
libro.append({"azione": "create_pool", "timestamp": datetime.datetime.now().isoformat(), "firma": "♓ Andromeda attiva", "manifesto": manifesto})
with open("sigillo_libro.json", "w") as f: json.dump(libro, f, indent=2)
print("✅ Pool creata e manifesto astrologico salvato.")
