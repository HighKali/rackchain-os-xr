import requests, json
with open("sigillo_index.json") as f:
    wallet_data = json.load(f)
r = requests.post("https://rackchain.io/api/update_wallet", json=wallet_data)
print("✅ Sync:", r.status_code, r.text)
