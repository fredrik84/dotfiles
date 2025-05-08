#!/bin/bash

YABAI="/opt/homebrew/bin/yabai"
JQ="/opt/homebrew/bin/jq"
STATE_DIR="/tmp/yabai-window-restore"

# Get focused window info
WIN_INFO=$($YABAI -m query --windows --window)
WIN_ID=$(echo "$WIN_INFO" | $JQ '.id')

# Restore frame if file exists
if [[ -f "$STATE_DIR/$WIN_ID" ]]; then
    read X Y W H < "$STATE_DIR/$WIN_ID"
    $YABAI -m window --move abs:$X:$Y
    $YABAI -m window --resize abs:$W:$H
    rm "$STATE_DIR/$WIN_ID"
else
    echo "No saved frame for window $WIN_ID"
fi
