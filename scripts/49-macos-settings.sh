#!/bin/bash
if [[ "$(uname)" == "Darwin" ]]; then
  chsh -s /bin/bash
  defaults write -g AppleEnableMenuBarTransparency -bool true
  defaults write NSGlobalDomain NSTableViewDefaultSizeMode -int 2
  defaults write -g NSDisableAutomaticTermination -bool true
  defaults write NSGlobalDomain AppleShowScrollBars -string "Always"
  defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false
  defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false
  defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false
  defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false
  defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false
  defaults write NSGlobalDomain AppleKeyboardUIMode -int 3
  defaults write com.apple.dock tilesize -int 32
  defaults write com.apple.dock largesize -int 64
  defaults write com.apple.dock "show-process-indicators" -int 1
  defaults write com.apple.dock "trash-full" -int 1
  defaults write com.apple.dock autohide -bool true
  defaults write com.apple.dock showhidden -bool true
  defaults write com.apple.dock magnification -int 1
  defaults write com.apple.dock mineffect -string "scale"
  defaults write com.apple.dock launchanim -bool false
  defaults write com.apple.dock mru-spaces -bool false
  defaults write com.apple.dock autohide-delay -float 0
fi
