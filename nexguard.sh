#!/bin/bash

# NexGuard - A tool to create a Nethunter Kex server

function install_dependencies() {
    echo "Installing necessary dependencies..."
    apt update && apt install -y xterm wget unzip python3 python3-pip curl
    pip3 install flask
    echo "Dependencies installed successfully."
}

function download_nethunter() {
    echo "Downloading Nethunter files..."
    wget https://downloads.kali.org/kali-linux-full.iso -O kali-full.iso
    wget https://downloads.kali.org/kali-linux-minimal.iso -O kali-minimal.iso
    wget https://downloads.kali.org/kali-linux-nano.iso -O kali-nano.iso
    echo "Nethunter files downloaded successfully."
}

function setup_kex() {
    echo "Setting up Kex in $1 mode..."
    case $1 in
        full)
            echo "Setting up Full mode..."
            # Commands specific to full mode
            # Add installation commands here
            ;;
        minimum)
            echo "Setting up Minimum mode..."
            # Commands specific to minimum mode
            # Add installation commands here
            ;;
        nano)
            echo "Setting up Nano mode..."
            # Commands specific to nano mode
            # Add installation commands here
            ;;
        *)
            echo "Invalid mode. Please choose from full, minimum, or nano."
            exit 1
            ;;
    esac
    echo "Kex has been set up in $1 mode."
}

function start_kex() {
    echo "Starting Kex server..."
    # Example command to start Kex
    nohup kex &> /dev/null &
    echo "Kex server started."
}

function stop_kex() {
    echo "Stopping Kex server..."
    pkill -f kex
    echo "Kex server stopped."
}

function list_kex_sessions() {
    echo "Listing active Kex sessions..."
    # Replace with actual commands to list Kex sessions
    echo "Session 1: Active"
    echo "Session 2: Inactive"
}

function create_local_server() {
    echo "Creating a simple Flask local server..."
    echo "from flask import Flask
app = Flask(__name__)

@app.route('/')
def home():
    return 'NexGuard Local Server is Running!'

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)" > server.py

    echo "Flask server code written to server.py."
    echo "Starting Flask server..."
    python3 server.py &
    echo "Flask server is running at http://localhost:5000"
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
        *)
            echo "Unknown command. Use 'nh ls', 'nh kex', 'nh stop', or 'nh create-server'."
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

    echo "NexGuard setup complete."
    echo "You can use 'nh' commands to manage your Kex server."
    echo "Available commands:"
    echo "  nh ls            - List active Kex sessions"
    echo "  nh kex           - Start Kex server"
    echo "  nh stop          - Stop Kex server"
    echo "  nh create-server  - Create a Flask local server"
}

main
