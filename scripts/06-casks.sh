#!/bin/bash
if [[ "$(uname)" == "Darwin" ]]; then
  FILE="schemas/$(echo $0 | cut -c '4-' | sed -e 's#.sh\$#.txt#')"
  brew install --casks $(cat $FILE | xargs)
fi
