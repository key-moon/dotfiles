# ================ begin config for zsh ================
# zplug
source ~/.zplug/init.zsh
zplug 'themes/alanpeabody', from:oh-my-zsh
zplug 'zsh-users/zsh-syntax-highlighting'
zplug 'zsh-users/zsh-completions'

if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi
zplug load

# dirstack
DIRSTACKSIZE=100
setopt AUTO_CD
setopt AUTO_PUSHD
# keybind
bindkey -e
# completion
fpath=('/home/keymoon/ghq/github.com/key-moon/chq/misc/zsh' $fpath)
zstyle :compinstall filename '/home/keymoon/.zshrc'
autoload -Uz compinit
compinit
zstyle ':completion:*' menu select=5
zstyle ':completion:*:descriptions' format '%BCompleting%b %U%d%u'
# history
setopt INC_APPEND_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt EXTENDED_HISTORY
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=1000000
function peco-select-history() {
  BUFFER=$(history -n -r 1 | peco --query "$LBUFFER")
  CURSOR=$#BUFFER
  zle clear-screen
}
zle -N peco-select-history
bindkey '^r' peco-select-history
# io
setopt IGNORE_EOF
# ghq
function peco-ghq () {
  local selected_dir=$(ghq list -p | peco --query "$LBUFFER")
  if [ -n "$selected_dir" ]; then
    BUFFER="cd ${selected_dir}"
    zle accept-line
  fi
  zle clear-screen
}
zle -N peco-ghq
bindkey '^g' peco-ghq
# chq
function peco-chq () {
  local ctf=$(chq ctx ctf --hide-key 2> /dev/null)
  if [ -n "$ctf" ]; then
    local ctf="$ctf/"
  fi
  local selected_dir=$(chq list -p | peco --query "$ctf")
  if [ -n "$selected_dir" ]; then
    BUFFER="cd ${selected_dir}"
    zle accept-line
  fi
  zle clear-screen
}
zle -N peco-chq
bindkey '^f' peco-chq
# ================= end config for zsh =================

# ================ begin general config ================
# enable color support
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi
alias bat='batcat'
alias cat='bat -pp'
alias ccat='bat -f -pp'
alias less='less -r'

# path
export PATH=$PATH:$HOME/tools
export PATH=$PATH:$HOME/.local/bin

# environment variables
# export TERM=xterm-256color
export ENVFILE_DIR=$HOME/.envfiles
export ENVFILE_NAME=ctf.env.sh
export GHIDRA_INSTALL_DIR=$HOME/bin/ghidra

# alias
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias config="/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"
alias clp='xclip -selection c'
alias ghidra="$GHIDRA_INSTALL_DIR/ghidraRun"
alias peco="peco --rcfile $HOME/.pecorc.json"
alias tgdb="gdb --nx -ix=~/.gdbinit_tmux"

# tmux
if [[ -n "$TMUX" ]] then
  alias clear="clear; tmux clear-history"
  alias reset="reset; tmux clear-history"
  function _clear { clear; tmux clear-history }
  zle -N _clear
  bindkey '^l' _clear
fi
# ================= end general config =================

# ============ begin config for application ============
[[ -s "$HOME/.gvm/scripts/gvm" ]] && source "$HOME/.gvm/scripts/gvm"
[[ -s "$HOME/templates/.bin/init.zsh" ]] && source "$HOME/templates/.bin/init.zsh"
# ============= end config for application =============
