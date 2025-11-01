# sigillo_index.py — Genera sigillo_index.json da policy_sigil.txt

import os
import re
import json

POLICY_PATH = os.path.expanduser("~/rackchain-os-xr/xr∞_industrial/policy_sigil.txt")
OUTPUT_PATH = os.path.expanduser("~/rackchain-os-xr/xr∞_industrial/sigillo_index.json")

def estrai_firme():
    if not os.path.exists(POLICY_PATH):
        return []
    with open(POLICY_PATH, "r") as f:
        testo = f.read()
    return re.findall(r"Firma del nodo: (.+?)\nData: (.+?)\n", testo)

def genera_index(firme):
    index = []
    for nodo, data in firme:
        index.append({
            "nodo": nodo,
            "firma": data,
            "ruolo": "governatore",
            "sigillo": "🧿",
            "status": "attivo"
        })
    return index

def salva_index(index):
    with open(OUTPUT_PATH, "w") as f:
        json.dump(index, f, indent=2)
    print(f"✅ Registro generato: {OUTPUT_PATH}")

# Esegui
if __name__ == "__main__":
    firme = estrai_firme()
    index = genera_index(firme)
    salva_index(index)

