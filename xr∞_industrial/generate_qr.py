import qrcode
import sys

data = sys.argv[1] if len(sys.argv) > 1 else "https://rackchain.xr"
img = qrcode.make(data)
img.save("vpn_qr.png")
print("✅ QR generato: vpn_qr.png")
