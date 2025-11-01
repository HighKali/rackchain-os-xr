import requests
payload = {
  "msgtype": "m.text",
  "body": "🔮 Wallet XR∞Coin sincronizzato con dsn-dashboard"
}
requests.post(
  "https://matrix.org/_matrix/client/r0/rooms/<ROOM_ID>/send/m.room.message?access_token=<TOKEN>",
  json=payload
)
