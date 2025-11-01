from flask import Flask, jsonify, send_from_directory
import json, os

app = Flask(__name__)

@app.route("/sigillo")
def sigillo():
    with open("sigillo_index.json") as f:
        return jsonify(json.load(f))

@app.route("/badge")
def badge():
    return send_from_directory(os.getcwd(), "sigillo_badge.svg")

@app.route("/libro")
def libro():
    with open("sigillo_libro.json") as f:
        return jsonify(json.load(f))

app.run(host="0.0.0.0", port=5000)
