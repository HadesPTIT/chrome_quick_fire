#!/bin/bash
set -e

APP="Chrome Quickfire.app"
BINARY="$APP/Contents/MacOS/WorkspaceManager"
RESOURCES="$APP/Contents/Resources"

echo "🔨 Building Mstart..."

# Kill running instance if any
killall WorkspaceManager 2>/dev/null || true

# Compile Swift source
swiftc main.swift -o "$BINARY"

# Copy config into app bundle (so it ships alongside the binary)
if [ -f "config.json" ]; then
  cp config.json "$RESOURCES/config.json"
  echo "📋 Bundled config.json"
else
  echo "⚠️  Warning: config.json not found. Copy config.example.json → config.json and fill in your values."
fi

# Sync Xcode project source
cp main.swift WorkspaceProject/Sources/WorkspaceManager/main.swift

# Touch app to clear macOS icon cache
touch "$APP"

echo "✅ Build complete. Launching..."
open "$APP"
