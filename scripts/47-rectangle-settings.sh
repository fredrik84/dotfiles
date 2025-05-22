#!/bin/bash

    centerThird =     {
        keyCode = 125;
        modifierFlags = 1048576;
    };
    firstThird =     {
        keyCode = 123;
        modifierFlags = 1048576;
    };

if [[ "$(uname)" == "Darwin" ]]; then
  defaults write com.knollsoft.Rectangle resizeOnDirectionalMove -bool true
  defaults write com.knollsoft.Rectangle launchOnLogin -bool true
  defaults write com.knollsoft.Rectangle centerThird -dict-add keyCode -float 125 modifierFlags -float 1048576
  defaults write com.knollsoft.Rectangle lastThird -dict-add keyCode -float 124 modifierFlags -float 1048576
  defaults write com.knollsoft.Rectangle firstThird -dict-add keyCode -float 123 modifierFlags -float 1048576
  defaults write com.knollsoft.Rectangle maximize -dict-add keyCode -float 126 modifierFlags -float 1048576
fi
