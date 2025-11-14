from datetime import datetime

def log_event(msg):
    with open("eco_log.txt", "a") as f:
        f.write(f"[{datetime.now()}] {msg}\n")
