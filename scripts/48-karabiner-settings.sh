#!/bin/bash
if [[ "$(uname)" == "Darwin" ]]; then
  chmod +x ~/.config/karabiner/scripts/*.sh
  yabai --start-service
  yabai --install-service
  yabai --load-sa
fi
