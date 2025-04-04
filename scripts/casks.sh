#!/bin/bash
brew install --casks $(cat casks.txt | xargs)
