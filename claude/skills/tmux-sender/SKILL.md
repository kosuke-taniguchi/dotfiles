---
name: tmux-sender
description: tmuxの別ペインにコマンドを送信する。「tmuxで送信」「ペインに送って」「codexに送信」等で起動。codex-review Skillから内部的にも利用される。
allowed-tools:
  - Bash(tmux:*)
---

# tmux-sender - tmuxペインへのコマンド送信

tmux の別ペインにコマンドを送信・実行する汎用スキル。

## 使い方

`tmux send-keys` を使って指定ペインにコマンドを送信する。

```bash
# 右ペイン（pane 1）にコマンドを送信
tmux send-keys -t right '<コマンド>' Enter
```

## 右ペインが存在しない場合

右ペインがなければ作成してから送信する。

```bash
# 右ペインの存在確認（失敗したら作成）
tmux select-pane -t right 2>/dev/null || tmux split-window -h
# 送信
tmux send-keys -t right '<コマンド>' Enter
```

## 注意事項

- 送信先のペインで別のプロセスが実行中でないか確認すること
- 長いコマンドはエスケープに注意
- シングルクォートを含むコマンドは適切にエスケープすること
