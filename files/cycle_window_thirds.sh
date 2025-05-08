#!/bin/bash

YABAI="/opt/homebrew/bin/yabai"
JQ="/opt/homebrew/bin/jq"

# Convert float to int
to_int() {
    printf "%.0f" "$1"
}

# Cycle direction (default: forward)
DIRECTION=${1:-forward}
ULTRAWIDE_THRESHOLD=4000  # adjust as needed

# Get focused window info
WIN_INFO=$($YABAI -m query --windows --window)
WIN_ID=$(echo "$WIN_INFO" | $JQ '.id')
WIN_X=$(to_int "$(echo "$WIN_INFO" | $JQ '.frame.x')")
DISPLAY_ID=$(echo "$WIN_INFO" | $JQ '.display')

# Get current display info
DISPLAY_INFO=$($YABAI -m query --displays | $JQ ".[] | select(.id == $DISPLAY_ID)")
SCREEN_X=$(to_int "$(echo "$DISPLAY_INFO" | $JQ '.frame.x')")
SCREEN_Y=$(to_int "$(echo "$DISPLAY_INFO" | $JQ '.frame.y')")
SCREEN_W=$(to_int "$(echo "$DISPLAY_INFO" | $JQ '.frame.w')")
SCREEN_H=$(to_int "$(echo "$DISPLAY_INFO" | $JQ '.frame.h')")

# Use 3 segments on ultrawide, 2 on others
if (( SCREEN_W >= ULTRAWIDE_THRESHOLD )); then
    COLUMNS=3
else
    COLUMNS=2
fi

SEGMENT_WIDTH=$((SCREEN_W / COLUMNS))
RELATIVE_X=$((WIN_X - SCREEN_X))

# Determine current column index
CURRENT_INDEX=$((RELATIVE_X / SEGMENT_WIDTH))

# Normalize index if out of bounds
if (( CURRENT_INDEX >= COLUMNS )); then
    CURRENT_INDEX=$((COLUMNS - 1))
fi

# Calculate new index based on direction
if [[ "$DIRECTION" == "forward" ]]; then
    NEW_INDEX=$(( (CURRENT_INDEX + 1) % COLUMNS ))
else
    NEW_INDEX=$(( (CURRENT_INDEX - 1 + COLUMNS) % COLUMNS ))
fi

# Compute new X position
NEW_X=$((SCREEN_X + SEGMENT_WIDTH * NEW_INDEX))

# Apply move + resize
$YABAI -m window --move abs:$NEW_X:$SCREEN_Y
$YABAI -m window --resize abs:$SEGMENT_WIDTH:$SCREEN_H
