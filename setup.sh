#!/bin/bash
for script in $(find scripts/ -type f); do
  bash $script
done
