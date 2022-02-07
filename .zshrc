unsetopt correct_all

export ZSH="$HOME/.oh-my-zsh"
export CASE_SENSITIVE="false"
export DISABLE_AUTO_TITLE="false"
export ENABLE_CORRECTION="true"
export HIST_STAMPS="yyyy-mm-dd"
export LANG=en_US.UTF-8
export EDITOR='vim'
export TEXT_EDITOR='code'
export BREW_PREFIX=$(brew --prefix)

BASEPATH="$BASEPATH:$BREW_PREFIX/bin"
BASEPATH="$BASEPATH:$BREW_PREFIX/sbin"
BASEPATH="$BASEPATH:$HOME/.composer/vendor/bin"
BASEPATH="$BASEPATH:$HOME/go/bin"
BASEPATH="$BASEPATH:$PATH"
BASEPATH="$BASEPATH:$BREW_PREFIX/share/zsh/site-functions/_brew"
BASEPATH="$BASEPATH:$HOME/utils"

export PATH="$BASEPATH"

plugins=(git golang macos docker)
source $ZSH/oh-my-zsh.sh

alias afk="pmset displaysleepnow"
alias flush="sudo dscacheutil -flushcache && sudo killall -HUP mDNSResponder"
alias grep="grep --color=auto"
alias fs="du -hs"
alias dl="open ~/Downloads"
alias dt="open ~/Desktop"
alias l="exa --long --group-directories-first"
alias ll="exa --long --all --group-directories-first"
alias ls="exa --all --group-directories-first"
alias cat="bat --paging=never --theme=Dracula --style=plain --number"
alias reload="source $HOME/.zshrc"
alias gp="git push origin HEAD"
alias dupes="pbpaste | sort -u | pbcopy"
alias ip.pub="dig +short myip.opendns.com @resolver1.opendns.com"
alias ip.net="ipconfig getifaddr en0"
alias ip.eth="ipconfig getifaddr en7"
alias mac.dock.left='defaults write com.apple.dock "orientation" -string "left" && killall Dock'
alias mac.dock.right='defaults write com.apple.dock "orientation" -string "right" && killall Dock'
alias mac.dock.bottom='defaults write com.apple.dock "orientation" -string "bottom" && killall Dock'
alias mac.dock.hide='defaults write com.apple.dock "autohide" -bool "true" && killall Dock'
alias mac.dock.show='defaults write com.apple.dock "autohide" -bool "false" && killall Dock'
alias mac.dock.recents.show='defaults write com.apple.dock "show-recents" -bool "true" && killall Dock'
alias mac.dock.recents.hide='defaults write com.apple.dock "show-recents" -bool "false" && killall Dock'
alias mac.extensions.show='defaults write NSGlobalDomain "AppleShowAllExtensions" -bool "false" && killall Finder'
alias mac.extensions.hide='defaults write NSGlobalDomain "AppleShowAllExtensions" -bool "true" && killall Finder'
alias mac.hiddenfiles.hide='defaults write com.apple.Finder "AppleShowAllFiles" -bool "false" && killall Finder'
alias mac.hiddenfiles.show='defaults write com.apple.Finder "AppleShowAllFiles" -bool "true" && killall Finder'

function strinfo {
    echo -e "\033[0;34mℹ\033[0m $*"
}

function strerr {
    echo -e "\033[0;31mⅹ\033[0m $*"
}

function strwarn {
    echo -e "\033[0;33m!\033[0m $*"
}

function strgood {
    echo -e "\033[0;32m✔\033[0m $*"
}

function confirm() {
    echo -n "$fg[blue]?$reset_color $1 (y/n)? "
    read answer

    if [ "$answer" != "${answer#[Yy]}" ] ;then
        return 0
    else
        return 1
    fi
}

function imgoptim() {
    for target in "$@"; do
        /Applications/ImageOptim.app/Contents/MacOS/ImageOptim $target 1> /dev/null 2> /dev/null
        strinfo "Compressed: $(basename $target)"
    done
}

function chpwd() {
    clear
    export PATH="$PWD/bin:$PWD/node_modules/.bin:$BASEPATH"
}

function precmd {
    #
}

if [ -f $HOME/.zshenv ]; then
    source $HOME/.zshenv
fi

# Completion scripts init and autoload
autoload -U compinit && compinit

# Autosuggestions
source $BREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh

eval "$(starship init zsh)"
