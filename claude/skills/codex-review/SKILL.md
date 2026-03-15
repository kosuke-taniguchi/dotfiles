---
name: codex-review
description: Codexによるレビューをtmuxの右ペインで実行する。「codexレビュー」「codex review」「コードレビュー依頼」「設計レビュー」「/codex-review」等で起動。
user-invocable: true
allowed-tools:
  - Bash(tmux:*)
  - Bash(codex:*)
  - Read
  - Glob
  - Grep
---

# /codex-review - Codexによるレビュー実行

tmuxの右ペインでCodexを起動し、設計レビューまたはコードレビューを実行する。

## 処理フロー

### Step 1: 右ペインの準備

```bash
# 右ペインが存在しなければ作成
tmux select-pane -t right 2>/dev/null || tmux split-window -h
# Claude側（左ペイン）に戻る
tmux select-pane -t left
```

### Step 2: レビュータイプの判定

状況に応じてレビュータイプを判定する:

- **設計レビュー**: Plan Modeの結果やPlanファイルが存在する場合
  - `codex exec` でPlan内容をレビュー依頼
- **コードレビュー**: git差分が存在する場合
  - `codex review` でコード差分をレビュー

### Step 3: レビュー実行

#### 設計レビューの場合

Planファイルの内容を読み取り、`codex exec` でレビューを依頼する。

```bash
tmux send-keys -t right 'codex exec "以下のPlan/設計をレビューしてください。問題点、改善提案、見落としがあれば指摘してください。" < <planファイルパス>' Enter
```

#### コードレビューの場合

```bash
# uncommitted changes がある場合
tmux send-keys -t right 'codex review --uncommitted' Enter

# ブランチの差分をレビューする場合
tmux send-keys -t right 'codex review --base main' Enter
```

### Step 4: 結果の確認

Codexのレビュー結果は右ペインに表示される。
必要に応じて `tmux capture-pane` で結果を取得できる。

```bash
# 右ペインの出力をキャプチャ
tmux capture-pane -t right -p -S -50
```

## 使用例

### ワークフロー2: Plan結果のレビュー
1. Claude が Plan Mode で設計完了
2. `/codex-review` または自動トリガーで Codex が右ペインで設計レビュー
3. レビュー結果を確認し、Claude が Plan を修正

### ワークフロー5: 最終コードレビュー
1. Claude が実装完了
2. 開発者が `/codex-review` を実行
3. Codex が右ペインでコード差分をレビュー
