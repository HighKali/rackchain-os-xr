import requests

def send_matrix_message(msg):
    url = "https://matrix.org/_matrix/client/r0/rooms/!tuaroomid:matrix.org/send/m.room.message"
    headers = {"Authorization": "Bearer TUO_TOKEN"}
    payload = {"msgtype": "m.text", "body": msg}
    requests.post(url, headers=headers, json=payload)
