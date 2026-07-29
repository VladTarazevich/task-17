#!/bin/sh

LOG_DIR="/var/log/nginx"
HTML_DIR="/usr/share/nginx/html"
MAIN_LOG="$LOG_DIR/access.log"
CLEAR_LOG="$LOG_DIR/clear_history.log"
ERR_500_LOG="$LOG_DIR/500_errors.log"
ERR_400_LOG="$LOG_DIR/400_errors.log"

MAX_SIZE=100

if [ -L "$MAIN_LOG" ]; then
    rm "$MAIN_LOG"
    touch "$MAIN_LOG"
    chmod 644 "$MAIN_LOG"
    nginx -s reload 2>/dev/null || kill -USR1 $(cat /var/run/nginx.pid)
fi

echo "Starting log parser and CPU monitor daemon"

while true; do
    echo "<pre>$(top -bn1 | head -n 5)</pre>" > "$HTML_DIR/cpu.html"

    if [ -f "$MAIN_LOG" ]; then
        FILE_SIZE=$(stat -c%s "$MAIN_LOG")
        
        if [ "$FILE_SIZE" -ge "$MAX_SIZE" ]; then
            echo "Log reached threshold ($FILE_SIZE bytes). Parsing and rotating..."
            
            awk '$9 ~ /^4/ {print}' "$MAIN_LOG" >> "$ERR_400_LOG"
            
            awk '$9 ~ /^5/ {print}' "$MAIN_LOG" >> "$ERR_500_LOG"
            
            truncate -s 0 "$MAIN_LOG"
            
            echo "Clear successful on: $(date). Previous size: $FILE_SIZE bytes" >> "$CLEAR_LOG"
        fi
    fi
    
    sleep 5
done