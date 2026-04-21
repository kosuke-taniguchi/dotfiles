# --- Powerlevel10k instant prompt (keep at top) ---
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# --- Go workspace (OK) ---
export GOPATH="$HOME/go"
export PATH="$PATH:$GOPATH/bin"

# --- Homebrew (必要なら) ---
export PATH="/opt/homebrew/bin:$PATH"

# --- Powerlevel10k theme ---
source /opt/homebrew/share/powerlevel10k/powerlevel10k.zsh-theme
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# --- Google Cloud SDK (path / completion) ---
if [ -f "/opt/homebrew/share/google-cloud-sdk/path.zsh.inc" ]; then
  . "/opt/homebrew/share/google-cloud-sdk/path.zsh.inc"
fi
if [ -f "/opt/homebrew/share/google-cloud-sdk/completion.zsh.inc" ]; then
  . "/opt/homebrew/share/google-cloud-sdk/completion.zsh.inc"
fi

# --- asdf (早めに initialze。GOROOTは設定しない) ---
. "$HOME/.asdf/asdf.sh"
# （任意）asdf 補完
if [ -f "$HOME/.asdf/completions/asdf.zsh" ]; then
  . "$HOME/.asdf/completions/asdf.zsh"
fi

# --- your aliases ---
alias k='kubectl'
alias 'k-use'='kubectl config use-context'
alias 'k-contexts'='kubectl config get-contexts'
alias 'k-current'='kubectl config current-context'
alias k9r='k9s --readonly'

### MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
export PATH="/Users/s20812/.rd/bin:$PATH"
### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)
