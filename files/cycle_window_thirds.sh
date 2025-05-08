#!/bin/bash

# Set paths to avoid Karabiner PATH issues
YABAI="/opt/homebrew/bin/yabai"
JQ="/opt/homebrew/bin/jq"

# Helper to truncate float
to_int() {
    printf "%.0f" "$1"
}

# Get direction
DIRECTION=${1:-forward}

# Get focused window info
WIN_INFO=$($YABAI -m query --windows --window)
WIN_X=$(to_int "$(echo "$WIN_INFO" | $JQ '.frame.x')")
DISPLAY_ID=$(echo "$WIN_INFO" | $JQ '.display')

# Get that display's frame
DISPLAY_INFO=$($YABAI -m query --displays | $JQ ".[] | select(.id == $DISPLAY_ID)")
SCREEN_X=$(to_int "$(echo "$DISPLAY_INFO" | $JQ '.frame.x')")
SCREEN_Y=$(to_int "$(echo "$DISPLAY_INFO" | $JQ '.frame.y')")
SCREEN_W=$(to_int "$(echo "$DISPLAY_INFO" | $JQ '.frame.w')")
SCREEN_H=$(to_int "$(echo "$DISPLAY_INFO" | $JQ '.frame.h')")

THIRD_WIDTH=$((SCREEN_W / 3))
RELATIVE_X=$((WIN_X - SCREEN_X))

# Decide where to move within the bounds of the display
if [[ "$DIRECTION" == "forward" ]]; then
    if (( RELATIVE_X < THIRD_WIDTH / 2 )); then
        NEW_X=$((SCREEN_X + THIRD_WIDTH))         # Left → Middle
    elif (( RELATIVE_X < THIRD_WIDTH * 2 )); then
        NEW_X=$((SCREEN_X + THIRD_WIDTH * 2))     # Middle → Right
    else
        NEW_X=$SCREEN_X                           # Right → Left
    fi
else
    if (( RELATIVE_X >= THIRD_WIDTH * 2 )); then
        NEW_X=$((SCREEN_X + THIRD_WIDTH))         # Right → Middle
    elif (( RELATIVE_X >= THIRD_WIDTH )); then
        NEW_X=$SCREEN_X                           # Middle → Left
    else
        NEW_X=$((SCREEN_X + THIRD_WIDTH * 2))     # Left → Right
    fi
fi

# Resize and move (only within this display!)
$YABAI -m window --resize abs:$THIRD_WIDTH:$SCREEN_H
$YABAI -m window --move abs:$NEW_X:$SCREEN_Y
