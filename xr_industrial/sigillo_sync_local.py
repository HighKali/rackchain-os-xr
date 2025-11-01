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
