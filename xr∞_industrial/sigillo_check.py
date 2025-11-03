# sigillo_check.py — Elenco dei nodi firmatari della policy XR∞

import os
import re

POLICY_PATH = os.path.expanduser("~/rackchain-os-xr/xr∞_industrial/policy_sigil.txt")

def estrai_firme():
    if not os.path.exists(POLICY_PATH):
        print("❌ Nessuna policy trovata.")
        return []

    with open(POLICY_PATH, "r") as f:
        testo = f.read()

    firme = re.findall(r"Firma del nodo: (.+?)\nData: (.+?)\n", testo)
    return firme

def mostra_firme():
    firme = estrai_firme()
    if not firme:
        print("⚠️ Nessun nodo ha ancora firmato la policy.")
        return

    print("📜 Nodi firmatari della policy XR∞:")
    for nodo, data in firme:
        print(f"🧿 {nodo} — firmato il {data}")

# Esempio d'uso:
if __name__ == "__main__":
    mostra_firme()
