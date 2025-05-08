#!/bin/bash

YABAI="/opt/homebrew/bin/yabai"
JQ="/opt/homebrew/bin/jq"
STATE_DIR="/tmp/yabai-window-restore"
mkdir -p "$STATE_DIR"

# Helper
to_int() {
    printf "%.0f" "$1"
}

# Get focused window info
WIN_INFO=$($YABAI -m query --windows --window)
WIN_ID=$(echo "$WIN_INFO" | $JQ '.id')
WIN_X=$(to_int "$(echo "$WIN_INFO" | $JQ '.frame.x')")
WIN_Y=$(to_int "$(echo "$WIN_INFO" | $JQ '.frame.y')")
WIN_W=$(to_int "$(echo "$WIN_INFO" | $JQ '.frame.w')")
WIN_H=$(to_int "$(echo "$WIN_INFO" | $JQ '.frame.h')")
DISPLAY_ID=$(echo "$WIN_INFO" | $JQ '.display')

# Save frame to file
echo "$WIN_X $WIN_Y $WIN_W $WIN_H" > "$STATE_DIR/$WIN_ID"

# Get display dimensions
DISPLAY_INFO=$($YABAI -m query --displays | $JQ ".[] | select(.id == $DISPLAY_ID)")
SCREEN_X=$(to_int "$(echo "$DISPLAY_INFO" | $JQ '.frame.x')")
SCREEN_Y=$(to_int "$(echo "$DISPLAY_INFO" | $JQ '.frame.y')")
SCREEN_W=$(to_int "$(echo "$DISPLAY_INFO" | $JQ '.frame.w')")
SCREEN_H=$(to_int "$(echo "$DISPLAY_INFO" | $JQ '.frame.h')")

# Maximize
$YABAI -m window --move abs:$SCREEN_X:$SCREEN_Y
$YABAI -m window --resize abs:$SCREEN_W:$SCREEN_H
