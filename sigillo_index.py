import json, hashlib, time
from eco_log import log_event

def genera_sigillo(nodo_id, zip_name):
    timestamp = time.time()
    hash_zip = hashlib.sha256(open(zip_name, "rb").read()).hexdigest()

    sigillo = {
        "nodo": nodo_id,
        "timestamp": timestamp,
        "zip": zip_name,
        "hash": hash_zip
    }

    with open("sigillo_index.json", "w") as f:
        json.dump(sigillo, f, indent=2)

    with open("sigillo_manifesto.txt", "w") as m:
        m.write(f"🧿 Manifesto Orbitale XR∞\n")
        m.write(f"Nodo ID: {nodo_id}\n")
        m.write(f"ZIP: {zip_name}\n")
        m.write(f"Timestamp: {timestamp}\n")
        m.write(f"SHA256: {hash_zip}\n")
        m.write(f"Commit Git: {get_commit_hash()}\n")
        m.write(f"QR: vpn_qr.png\n")

    log_event(f"🧿 Sigillo registrato: {zip_name} | {hash_zip}")
    return sigillo

def get_commit_hash():
    import subprocess
    return subprocess.check_output(["git", "rev-parse", "HEAD"]).decode().strip()

