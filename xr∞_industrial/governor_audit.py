# governor_audit.py — Verifica rituale per elevazione a governatore XR∞

import os
import datetime

LOG_PATH = os.path.expanduser("~/rackchain-os-xr/xr∞_industrial/eco_log.txt")
BOINC_LOG = os.path.expanduser("~/rackchain-os-xr/xr∞_industrial/boinc_log.txt")
POLICY_SIGIL_PATH = os.path.expanduser("~/rackchain-os-xr/xr∞_industrial/policy_sigil.txt")

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

def verifica_firma_policy(node_id):
    if not os.path.exists(POLICY_SIGIL_PATH):
        return False
    with open(POLICY_SIGIL_PATH, "r") as f:
        return node_id in f.read()

def audit_governatore(node_id):
    uptime = estrai_uptime(node_id)
    boinc = estrai_boinc_credit(node_id)
    firmato = verifica_firma_policy(node_id)

    print(f"🔍 Audit nodo: {node_id}")
    print(f"🕒 Uptime registrato: {uptime}")
    print(f"🧪 BOINC credit: {boinc}")
    print(f"📜 Firma su policy: {'✅' if firmato else '❌'}")

    if uptime >= 99 and boinc >= 1000 and firmato:
        print(f"👑 Nodo {node_id} è idoneo come GOVERNATORE XR∞")
        return True
    else:
        print(f"❌ Nodo {node_id} non idoneo: uptime={uptime}, BOINC={boinc}, policy={'firmata' if firmato else 'non firmata'}")
        return False

# Esempio d'uso:
if __name__ == "__main__":
    audit_governatore("vpn-001")
