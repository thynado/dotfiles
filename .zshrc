export ZSH="$HOME/.oh-my-zsh"
export PATH="$PATH:$HOME/.composer/vendor/bin"
export CASE_SENSITIVE="false"
export DISABLE_AUTO_TITLE="false"
export ENABLE_CORRECTION="true"
export HIST_STAMPS="yyyy-mm-dd"
export LANG=en_US.UTF-8
export EDITOR='vim'

alias cat="bat --paging=never --theme=Dracula --style=numbers"
alias reload="source $HOME/.zshrc"
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

function precmd {
    #
}

plugins=(git golang macos docker)
source $ZSH/oh-my-zsh.sh
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
eval "$(starship init zsh)"