# ===== Git Support =====
autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst
RPROMPT='${vcs_info_msg_0_}'
# # PROMPT='${vcs_info_msg_0_}%# '
# zstyle ':vcs_info:git:*' formats '%b'

zstyle ':vcs_info:git*:*' check-for-changes true
zstyle ':vcs_info:git*:*' unstagedstr '|U'
zstyle ':vcs_info:git*:*' stagedstr '|≠'

# enable hooks, requires Zsh >=4.3.11
if [[ $ZSH_VERSION == 4.3.<11->* || $ZSH_VERSION == 4.<4->* || $ZSH_VERSION == <5->* ]] ; then
  # hook for untracked files
  +vi-untracked() {
    if [[ $(git rev-parse --is-inside-work-tree 2>/dev/null) == 'true'  ]] && \
       [[ -n $(git ls-files --others --exclude-standard) ]] ; then
       hook_com[staged]+='|☂'
    fi
  }

  # unpushed commits
  +vi-outgoing() {
    local gitdir="$(git rev-parse --git-dir 2>/dev/null)"
    [ -n "$gitdir" ] || return 0

    if [ -r "${gitdir}/refs/remotes/git-svn" ] ; then
      local count=$(git rev-list remotes/git-svn.. 2>/dev/null | wc -l)
    else
      local branch="$(cat ${gitdir}/HEAD 2>/dev/null)"
      branch=${branch##*/heads/}
      local count=$(git rev-list remotes/origin/${branch}.. 2>/dev/null | wc -l)
    fi

    if [[ "$count" -gt 0 ]] ; then
      hook_com[staged]+="|↑$count"
    fi
  }

  # hook for stashed files
  +vi-stashed() {
    if git rev-parse --verify refs/stash &>/dev/null ; then
      hook_com[staged]+='|s'
    fi
  }

  zstyle ':vcs_info:git*+set-message:*' hooks stashed untracked outgoing
fi

# extend default vcs_info in prompt
zstyle ':vcs_info:*' actionformats "(%s)-[%b|%a%u%c] " "zsh: %r"
zstyle ':vcs_info:*' formats       "(%s)-[%b%u%c]%} " "zsh: %r"

# ===== Completion =====
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

# ===== History =====
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory

# ===== Prompt =====
PS1="%n@%m:%~$ "
PS2="%_> "

# ===== Key Bindings =====
bindkey '^[[1;5C' forward-word  # Ctrl + Right Arrow
bindkey '^[[1;5D' backward-word # Ctrl + Left Arrow

# ===== Alias =====
alias ls='ls --color=auto'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias grep='grep --color=auto'
alias ..='cd ..'

# Export ~/.bin folder
export PATH="$HOME/.bin:$PATH"


# Git configuration
alias clear_git_cache='git rm -r --cached .'  # remove all files from the git cache
alias clear_git_tags='git tag -l | xargs git tag -d'  # remove all tags from the git repository

# Svn configuration
export SVN_EDITOR=nvim

# opam configuration
[[ ! -r /home/fcb/.opam/opam-init/init.zsh ]] || source /home/fcb/.opam/opam-init/init.zsh  > /dev/null 2> /dev/null

# rust configuration
. "$HOME/.cargo/env"

# Set JAVA_HOME to the desired version
export JAVA_HOME=/usr/lib/jvm/java-21-openjdk
export PATH=$JAVA_HOME/bin:$PATH

# LLVM configuration
export PATH=$PATH:/usr/lib/llvm14/bin

# Latex configuration
export TEXEDIT="nvim +%d %s"
export PATH=$PATH:/usr/local/texlive/2024/bin/x86_64-linux
export BIBINPUTS=$HOME/texmf/tex/latex/adapt-lab/trunk/bibs:.

l4p() {  # it assumes to have $BIBINPUTS set and with the dir to look into as the first one
  BIB_DIR=${BIBINPUTS%%:*}
  grep -rin"$2" -ie "$1" "$BIB_DIR"/*.bib
}

vimbib() { # it assumes to have $BIBINPUTS set and with the dir to look into as the first one
  BIB_DIR=${BIBINPUTS%%:*}
  # local bibs=()
  # for bib in "$@"
  # do
  #    bibs+=($BIB_DIR/"$bib"".bib")
  # done
  local bibs=($@)
  bibs=("${bibs[@]/%/.bib}")
  bibs=( "${bibs[@]/#/$BIB_DIR/}" )
  echo "${bibs[@]}"

  vim -p "${bibs[@]}"
}

# tgt
alias tgt='~/dev/tgt/target/release/tgt'

# tgt
export LOCAL_TDLIB_PATH=$HOME/lib/tdlib

# Telegram API configuration
# export API_ID="94575"
# export API_HASH="a3406de8d171bb422bb6ddf3bbd800e2"

# pkg-config configuration
# export PKG_CONFIG_PATH=$HOME/lib/tdlib/lib/pkgconfig/:$PKG_CONFIG_PATH

# dynmic linker configuration
# export LD_LIBRARY_PATH=$HOME/lib/tdlib/lib/:$LD_LIBRARY_PATH

# Xrandr configuration
alias start_second_monitor_right='xrandr --output HDMI-1-1 --auto --right-of eDP-1'
alias start_second_monitor_left='xrandr --output HDMI-1-1 --auto --left-of eDP-1'
alias start_second_monitor_above='xrandr --output HDMI-1-1 --auto --above eDP-1'
alias start_second_monitor_below='xrandr --output HDMI-1-1 --auto --below eDP-1'
alias stop_second_monitor='xrandr --output HDMI-1-1 --off'

# fzf
# export FZF_DEFAULT_OPTS='--height 50% --layout reverse --border --multi --preview "cat {}" --preview-window down:50%:wrap'
source ~/.config/fzf/completion.zsh
source ~/.config/fzf/key-bindings.zsh

# Cursor speed
alias inc_cursor_speed='xset r rate 400 65'

# open
alias open='xdg-open'

# Start Docker
# systemctl start docker

inc_cursor_speed

