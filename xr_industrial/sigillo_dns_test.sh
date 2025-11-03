#!/data/data/com.termux/files/usr/bin/bash
echo "🔍 Test DNS per rackchain.io"
nslookup rackchain.io
echo "🌐 Test ping:"
ping -c 3 rackchain.io
echo "📡 Test curl:"
curl -I https://rackchain.io
