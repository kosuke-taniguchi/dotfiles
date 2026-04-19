#!/bin/bash
set -euo pipefail

# ---------------------------------------------------------------------------
# macOS defaults
# ---------------------------------------------------------------------------

echo "==> macOS defaults"

# Dock
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock tilesize -int 39
defaults write com.apple.dock show-recents -bool false

# キーリピート (小さいほど速い)
defaults write NSGlobalDomain KeyRepeat -int 2
defaults write NSGlobalDomain InitialKeyRepeat -int 15

echo "  Dock, keyboard configured"

# ---------------------------------------------------------------------------
# Warp
# ---------------------------------------------------------------------------

echo "==> Warp defaults"

defaults write dev.warp.Warp-Stable Theme '"Adeberry"'
defaults write dev.warp.Warp-Stable OverrideOpacity -int 60
defaults write dev.warp.Warp-Stable FontSize -string "12.0"
defaults write dev.warp.Warp-Stable NotebookFontSize -string "14.0"

echo "  Theme, Opacity, FontSize configured"

# ---------------------------------------------------------------------------
# Apply
# ---------------------------------------------------------------------------

killall Dock 2>/dev/null || true
echo ""
echo "Done! Some changes may require logout/restart to take effect."
