# sigillo_forge.py — Firma rituale della policy etica XR∞

import os
import datetime

NODE_ID = os.uname().nodename
DATA = datetime.datetime.now().strftime("%Y-%m-%d")
POLICY_PATH = os.path.expanduser("~/rackchain-os-xr/xr∞_industrial/policy_sigil.txt")

firma = f"Firma del nodo: {NODE_ID}\nData: {DATA}\n" + ("─" * 60) + "\n"

# Verifica se già firmato
if os.path.exists(POLICY_PATH):
    with open(POLICY_PATH, "r") as f:
        if NODE_ID in f.read():
            print(f"⚠️ Nodo {NODE_ID} ha già firmato la policy.")
            exit(0)

# Appone la firma
with open(POLICY_PATH, "a") as f:
    f.write(firma)

print(f"✅ Nodo {NODE_ID} ha firmato la policy XR∞ il {DATA}")
