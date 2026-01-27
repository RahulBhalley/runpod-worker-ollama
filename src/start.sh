#!/bin/bash
set -e

cleanup() {
    echo "Cleaning up..."
    pkill -P $$ || true
    exit 0
}

trap cleanup SIGINT SIGTERM

# --- START HEALTH SERVER FIRST (CRITICAL) ---
echo "Starting health server..."
python health_server.py &
HEALTH_PID=$!

# --- START OLLAMA ---
echo "Starting Ollama..."
pgrep ollama | xargs kill || true
ollama serve 2>&1 | tee ollama.server.log &
OLLAMA_PID=$!

# --- WAIT FOR OLLAMA ---
check_server_is_running() {
    grep -q "Listening" ollama.server.log
}

while ! check_server_is_running; do
    sleep 5
done

# --- OPTIONAL MODEL PULL ---
if [ -n "$OLLAMA_MODEL_NAME" ]; then
    echo "Pulling model $OLLAMA_MODEL_NAME..."
    ollama pull "$OLLAMA_MODEL_NAME"
else
    echo "No model name provided. Skipping model pull..."
fi

# --- START MAIN HANDLER ---
echo "Starting handler..."
python -u handler.py "$1"

wait
