# required for *formats in vcs_info, see below
# BLUE="%F{blue}"
# RED="%F{red}"
# GREEN="%F{green}"
# CYAN="%F{cyan}"
# MAGENTA="%F{magenta}"
# YELLOW="%F{yellow}"
# WHITE="%F{white}"
# NO_COLOR="%f"

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory

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
zstyle ':vcs_info:*' actionformats "(%s)-[%b|%a%u%c] " "zsh: %r" # zstyle ':vcs_info:*' actionformats "${MAGENTA}(${NO_COLOR}%s${MAGENTA})${YELLOW}-${MAGENTA}[${GREEN}%b${YELLOW}|${RED}%a%u%c${MAGENTA}]${NO_COLOR} " "zsh: %r"
zstyle ':vcs_info:*' formats       "(%s)-[%b%u%c]%} " "zsh: %r" # zstyle ':vcs_info:*' formats       "${MAGENTA}(${NO_COLOR}%s${MAGENTA})${YELLOW}-${MAGENTA}[${GREEN}%b%u%c${MAGENTA}]${NO_COLOR}%} " "zsh: %r"


source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

# PS1="%B%F{blue}%n%F{green}@%m %F{yellow}%~%f%b %# "
PS1="%n@%m:%~$ "
PS2="%_> "

# opam configuration
[[ ! -r /home/fcb/.opam/opam-init/init.zsh ]] || source /home/fcb/.opam/opam-init/init.zsh  > /dev/null 2> /dev/null

# rust configuration
. "$HOME/.cargo/env"

# Export ~/.bin folder
export PATH="$HOME/.bin:$PATH"

# Git configuration
alias clear_git_cache='git rm -r --cached .'  # remove all files from the git cache
alias clear_git_tags='git tag -l | xargs git tag -d'  # remove all tags from the git repository

# Svn configuration
export SVN_EDITOR=nvim

# Latex configuration
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
alias tgt='~/Documents/tgt/target/release/tgt'

# tgt
export LOCAL_TDLIB_PATH=$HOME/lib/tdlib

# LLVM configuration
export PATH=$PATH:/usr/lib/llvm14/bin

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
alias inc_cursor_speed='xset r rate 400 50'

# open
alias open='xdg-open'

# Zed
alias zed='~/zed/target/release/zed &'

# Start Docker
# systemctl start docker

inc_cursor_speed
