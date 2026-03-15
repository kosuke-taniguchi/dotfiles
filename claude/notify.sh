#!/bin/bash
input=$(cat)
cwd=$(echo "$input" | jq -r '.cwd')
project=$(basename "$cwd")
notification_type=$(echo "$input" | jq -r '.notification_type // empty')
hook_event_name=$(echo "$input" | jq -r '.hook_event_name // empty')

if [ "$hook_event_name" = "Stop" ]; then
  terminal-notifier -title "Claude Code" -subtitle "$project" -message "タスク完了" -sound "Glass"
elif [ "$notification_type" = "permission_prompt" ]; then
  terminal-notifier -title "Claude Code" -subtitle "$project" -message "許可待ち" -sound "Ping"
elif [ "$notification_type" = "idle_prompt" ]; then
  terminal-notifier -title "Claude Code" -subtitle "$project" -message "入力待ち" -sound "Purr"
else
  terminal-notifier -title "Claude Code" -subtitle "$project" -message "通知" -sound ""
fi
