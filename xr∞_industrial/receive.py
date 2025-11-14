from flask import Flask, request
from eco_log import log_event

app = Flask(__name__)
VALID_KEYS = {"xr∞_node_001": "orbita_segreta_∞"}

@app.route('/node/receive', methods=['POST'])
def receive():
    data = request.get_json()
    key, secret = data.get("api_key"), data.get("api_secret")
    if VALID_KEYS.get(key) == secret:
        log_event(f"✅ Nodo autenticato: {key}")
        return {"status": "success"}, 200
    else:
        log_event(f"❌ Tentativo fallito: {data}")
        return {"status": "unauthorized"}, 403

if __name__ == "__main__":
    app.run(port=5000)
