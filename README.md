# YASIN-TRACKER-V2

**Live Tracking Tool for Android using Termux + Ngrok + Telegram.**

This tool generates a ngrok URL, converts it to a QR Code, and sends both to your Telegram bot. When scanned and opened, the target's browser sends their geolocation to your Telegram chat.

---

## Features

- Local PHP server launch
- Ngrok tunnel creation
- Secure URL generation
- QR Code creation
- Telegram bot integration
- Sends QR Code + live link to your Telegram

---

## Requirements

- Termux (Android)
- Telegram bot token and chat ID
- Ngrok account with auth token added

---

## Installation

```bash
pkg update -y
pkg install git -y
git clone https://github.com/YOUR_USERNAME/YASIN-TRACKER-V2
cd YASIN-TRACKER-V2
bash tracker_v2.sh
