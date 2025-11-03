# validator_audit.py — Verifica rituale per elevazione a validatore XR∞

import os
import datetime

LOG_PATH = os.path.expanduser("~/rackchain-os-xr/xr∞_industrial/eco_log.txt")
BOINC_LOG = os.path.expanduser("~/rackchain-os-xr/xr∞_industrial/boinc_log.txt")

def estrai_uptime(node_id):
    count = 0
    with open(LOG_PATH, "r") as f:
        for line in f:
            if node_id in line:
                count += 1
    return count

def estrai_boinc_credit(node_id):
    credit = 0
    if os.path.exists(BOINC_LOG):
        with open(BOINC_LOG, "r") as f:
            for line in f:
                if node_id in line:
                    try:
                        credit = int(line.strip().split()[-1])
                    except:
                        pass
    return credit

def audit_validatore(node_id):
    uptime = estrai_uptime(node_id)
    boinc = estrai_boinc_credit(node_id)

    print(f"🔍 Audit nodo: {node_id}")
    print(f"🕒 Uptime registrato: {uptime}")
    print(f"🧪 BOINC credit: {boinc}")

    if uptime >= 95 and boinc >= 500:
        print(f"✅ Nodo {node_id} è idoneo come VALIDATORE XR∞")
        return True
    else:
        print(f"❌ Nodo {node_id} non idoneo: uptime={uptime}, BOINC={boinc}")
        return False

# Esempio d'uso:
if __name__ == "__main__":
    audit_validatore("vpn-001")
