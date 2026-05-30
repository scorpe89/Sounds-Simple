#!/bin/bash
set -e

APP_DIR="$(cd "$(dirname "$0")" && pwd)"
SOURCE_APP="$APP_DIR/Sounds Simple.app"
DEST_APP="/Applications/Sounds Simple.app"

if [ ! -d "$SOURCE_APP" ]; then
  echo "Could not find Sounds Simple.app next to this installer."
  exit 1
fi

echo "Installing Sounds Simple to /Applications..."
ditto "$SOURCE_APP" "$DEST_APP"

echo "Installed:"
echo "$DEST_APP"
open -R "$DEST_APP"
