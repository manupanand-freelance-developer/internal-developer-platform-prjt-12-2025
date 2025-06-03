#!/bin/bash

# Check if commit message is passed
if [ -z "$1" ]; then
  echo "Usage: $0 <commit-message>"
  exit 1
fi



    git add .
    git commit -m "$1"
    git push origin main

    # Delete existing tag 'latest' if it exists (both local and remote), then re-create it
    git tag -d latest 2>/dev/null
    git push origin :refs/tags/latest 2>/dev/null

    git tag latest
    git push origin latest

    git status
 