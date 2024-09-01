# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
    zsh-autosuggestions
    git
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

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

inc_cursor_speed
