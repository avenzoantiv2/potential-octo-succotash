#!/bin/bash

# NexGuard - A tool to create a Nethunter Kex server
# Developed by: XKernel Development
# Credits: CodeCrafters (Develope Net Key X)

function install_dependencies() {
    echo "[*] Installing necessary dependencies..."
    apt update && apt install -y xterm wget unzip python3 python3-pip curl tigervnc-standalone-server
    pip3 install flask
    echo "[✔] Dependencies installed successfully."
}

function download_nethunter() {
    echo "[*] Downloading Nethunter files..."
    wget https://downloads.kali.org/kali-linux-full.iso -O kali-full.iso
    wget https://downloads.kali.org/kali-linux-minimal.iso -O kali-minimal.iso
    wget https://downloads.kali.org/kali-linux-nano.iso -O kali-nano.iso
    echo "[✔] Nethunter files downloaded successfully."
}

function setup_kex() {
    echo "[*] Setting up Kex in $1 mode..."
    case $1 in
        full)
            echo "[✔] Full mode setup complete."
            ;;
        minimum)
            echo "[✔] Minimum mode setup complete."
            ;;
        nano)
            echo "[✔] Nano mode setup complete."
            ;;
        *)
            echo "[✖] Invalid mode. Choose: full, minimum, or nano."
            exit 1
            ;;
    esac
}

function setup_vnc() {
    echo "[*] Configuring VNC user..."
    mkdir -p ~/.vnc
    echo "Enter a password for VNC access:"
    vncpasswd
    chmod 600 ~/.vnc/passwd
    echo "[✔] VNC setup complete."
}

function start_kex() {
    echo "[*] Starting Kex server..."
    vncserver :1 -geometry 1280x720
    echo "[✔] Kex server started on localhost:1"
}

function stop_kex() {
    echo "[*] Stopping Kex server..."
    vncserver -kill :1
    echo "[✔] Kex server stopped."
}

function list_kex_sessions() {
    echo "[*] Listing active Kex sessions..."
    vncserver -list
}

function create_local_server() {
    echo "[*] Creating a simple Flask local server..."
    echo "from flask import Flask
app = Flask(__name__)

@app.route('/')
def home():
    return 'NexGuard Local Server is Running!'

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)" > server.py

    echo "[✔] Flask server code written to server.py."
    echo "[*] Starting Flask server..."
    python3 server.py &
    echo "[✔] Flask server is running at http://localhost:5000"
}

function nh() {
    case $1 in
        ls)
            list_kex_sessions
            ;;
        kex)
            start_kex
            ;;
        stop)
            stop_kex
            ;;
        create-server)
            create_local_server
            ;;
        localhost)
            echo "[*] Connecting to Nethunter Kex on localhost..."
            vncviewer localhost:1
            ;;
        *)
            echo "[✖] Unknown command. Use:"
            echo "  nh ls             - List active Kex sessions"
            echo "  nh kex            - Start Kex server"
            echo "  nh stop           - Stop Kex server"
            echo "  nh create-server  - Create a Flask local server"
            echo "  nh localhost      - Connect to Kex VNC on localhost"
            ;;
    esac
}

function main() {
    echo "Welcome to NexGuard!"
    echo "Choose installation mode: full, minimum, or nano"
    read -p "Mode: " mode
    install_dependencies
    download_nethunter
    setup_kex $mode
    setup_vnc

    echo "[✔] NexGuard setup complete."
    echo "Use 'nh' commands to manage your Kex server."
    echo "Available commands:"
    echo "  nh ls             - List active Kex sessions"
    echo "  nh kex            - Start Kex server"
    echo "  nh stop           - Stop Kex server"
    echo "  nh create-server  - Create a Flask local server"
    echo "  nh localhost      - Connect to Kex VNC on localhost"
}

main
