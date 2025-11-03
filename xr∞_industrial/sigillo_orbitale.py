from eco_log import log_event
from sigillo_matrix import send_matrix_message
import json, time

def attiva_sigillo(nodo_id):
    timestamp = time.time()
    sigillo = {
        "nodo": nodo_id,
        "timestamp": timestamp,
        "status": "attivo"
    }
    with open("sigillo_index.json", "w") as f:
        json.dump(sigillo, f, indent=2)
    log_event(f"🧿 Sigillo orbitale attivato per {nodo_id}")
    send_matrix_message(f"🧿 Sigillo attivato: {nodo_id} @ {timestamp}")
