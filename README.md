# dotfiles

macOS 環境の設定ファイルとセットアップスクリプト。

## セットアップ

```bash
git clone git@github.com:kosuke-taniguchi/dotfiles.git ~/dotfiles
cd ~/dotfiles
./install.sh
```

`install.sh` は以下を実行する:

1. **Homebrew** のインストール（未導入の場合）
2. **Brewfile** に基づくパッケージの一括インストール
3. **asdf** のインストール（未導入の場合）
4. **シンボリックリンク** の作成（既存ファイルは `.bak` にバックアップされる）

macOS やアプリの設定（Dock、キーリピート、Warp の外観など）は `macos.sh` で別途適用する:

```bash
./macos.sh
```

## 構成

```
.zshrc                  -> ~/.zshrc
git/gitconfig           -> ~/.gitconfig
git/ignore              -> ~/.config/git/ignore
ssh/config              -> ~/.ssh/config
wezterm/wezterm.lua     -> ~/.config/wezterm/wezterm.lua
warp/keybindings.yaml   -> ~/.warp/keybindings.yaml
cursor/keybindings.json -> ~/Library/Application Support/Cursor/User/keybindings.json
cursor/settings.json    -> ~/Library/Application Support/Cursor/User/settings.json
claude/settings.json    -> ~/.claude/settings.json
claude/CLAUDE.md        -> ~/.claude/CLAUDE.md
claude/notify.sh        -> ~/.claude/notify.sh
claude/statusline.js    -> ~/.claude/statusline.js
claude/skills/          -> ~/.claude/skills/
```

## 個別実行

Homebrew パッケージのみ同期する場合:

```bash
brew bundle --file=~/dotfiles/Brewfile
```

## 設定の変更

シンボリックリンクで管理しているため、リンク先（例: `~/.zshrc`）を直接編集すればリポジトリに反映される。

```bash
# 例: .zshrc を編集後
cd ~/dotfiles
git add .zshrc
git commit -m "update zshrc"
git push
```
