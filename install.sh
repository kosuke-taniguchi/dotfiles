#!/bin/bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"

# ---------------------------------------------------------------------------
# Helper
# ---------------------------------------------------------------------------
link_file() {
  local src="$1"
  local dest="$2"
  local dest_dir
  dest_dir="$(dirname "$dest")"

  mkdir -p "$dest_dir"

  if [ -L "$dest" ]; then
    rm "$dest"
  elif [ -e "$dest" ]; then
    echo "  backup: $dest -> ${dest}.bak"
    mv "$dest" "${dest}.bak"
  fi

  ln -s "$src" "$dest"
  echo "  linked: $dest -> $src"
}

# ---------------------------------------------------------------------------
# Homebrew
# ---------------------------------------------------------------------------
echo "==> Homebrew"
if ! command -v brew &>/dev/null; then
  echo "  Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  eval "$(/opt/homebrew/bin/brew shellenv)"
else
  echo "  already installed"
fi

# ---------------------------------------------------------------------------
# Homebrew packages (via Brewfile)
# ---------------------------------------------------------------------------
echo "==> Homebrew packages"
brew bundle --file="$DOTFILES_DIR/Brewfile"

# ---------------------------------------------------------------------------
# asdf
# ---------------------------------------------------------------------------
echo "==> asdf"
if [ ! -d "$HOME/.asdf" ]; then
  echo "  Installing asdf..."
  git clone https://github.com/asdf-vm/asdf.git "$HOME/.asdf" --branch v0.16.7
else
  echo "  already installed"
fi

# ---------------------------------------------------------------------------
# Symlinks
# ---------------------------------------------------------------------------
echo "==> Symlinks"

# zsh
link_file "$DOTFILES_DIR/.zshrc" "$HOME/.zshrc"

# git
link_file "$DOTFILES_DIR/git/gitconfig" "$HOME/.gitconfig"
link_file "$DOTFILES_DIR/git/ignore" "$HOME/.config/git/ignore"

# ssh
link_file "$DOTFILES_DIR/ssh/config" "$HOME/.ssh/config"
chmod 600 "$HOME/.ssh/config"

# wezterm
link_file "$DOTFILES_DIR/wezterm/wezterm.lua" "$HOME/.config/wezterm/wezterm.lua"

# warp
link_file "$DOTFILES_DIR/warp/keybindings.yaml" "$HOME/.warp/keybindings.yaml"

# cursor
link_file "$DOTFILES_DIR/cursor/keybindings.json" "$HOME/Library/Application Support/Cursor/User/keybindings.json"
link_file "$DOTFILES_DIR/cursor/settings.json" "$HOME/Library/Application Support/Cursor/User/settings.json"

# claude code
link_file "$DOTFILES_DIR/claude/settings.json" "$HOME/.claude/settings.json"
link_file "$DOTFILES_DIR/claude/CLAUDE.md" "$HOME/.claude/CLAUDE.md"
link_file "$DOTFILES_DIR/claude/notify.sh" "$HOME/.claude/notify.sh"
chmod +x "$HOME/.claude/notify.sh"
link_file "$DOTFILES_DIR/claude/statusline.js" "$HOME/.claude/statusline.js"
chmod +x "$HOME/.claude/statusline.js"
link_file "$DOTFILES_DIR/claude/skills/codex-review" "$HOME/.claude/skills/codex-review"

echo ""
echo "Done! Restart your shell or run: source ~/.zshrc"
echo "To apply macOS / app settings, run: ./macos.sh"
