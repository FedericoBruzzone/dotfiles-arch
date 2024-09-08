HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory

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
