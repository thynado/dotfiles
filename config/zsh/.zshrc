# OhMyZsh settings
ZSH_THEME="dot"
TERM=xterm-256color
HIST_STAMPS="mm/dd/yyyy"
DISABLE_AUTO_TITLE="true"
plugins=(git laravel5 docker npm)
# BASEPATH="/usr/local/opt/python/libexec/bin:/usr/local/bin:/usr/local/sbin:$HOME/.composer/vendor/bin:$HOME/go/bin:$PATH:/usr/local/share/zsh/site-functions/_brew"
BASEPATH="/usr/local/opt/python/libexec/bin:/usr/local/bin:/usr/local/sbin:$HOME/.composer/vendor/bin:$PATH"

# Environment settings
export EDITOR="vim"
export TEXT_EDITOR="code"
export LANG=en_US.UTF-8
export PATH="$BASEPATH"
export TZ="America/Chicago"
export ZSH=$HOME/.oh-my-zsh
export NODE_PATH="/usr/local/lib/node_modules"

# Unset, disable, etc.
unsetopt PROMPT_SP

# Start up
source $ZSH/oh-my-zsh.sh
autoload -U compinit && compinit
title " "

# Git helpers
alias gt="git tag"
alias gp="git push origin HEAD"

# Get list of changed files in current branch existence in comparison to master.
gdl () {
    git diff --name-only $(git rev-parse --abbrev-ref HEAD) $(git merge-base $(git rev-parse --abbrev-ref HEAD) master)
}

###################################################################### Laravel
alias artisan="php artisan"
alias tinker="php artisan tinker"

###################################################################### OhMyZsh
alias rc="$TEXT_EDITOR ~/.zshrc"

###################################################################### Directories
alias dl="open ~/Downloads"
alias dt="open ~/Desktop"

###################################################################### Helpers
alias coffee="afk ; morning"
alias delete-all-those-ridiculous-ds-store-files="find . -name '*.DS_Store' -type f -ls -delete"    # Remove DS_Store files
alias fs="stat -f \"%z bytes\""
alias battery="pmset -g batt | egrep \"([0-9]+\%).*\" -o --colour=auto | cut -f1 -d';'"
alias grep="grep --color=auto"
alias airport="/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport"
alias flush="sudo dscacheutil -flushcache && sudo killall -HUP mDNSResponder"
alias paths='echo -e ${PATH//:/\\n}'
alias bye="/System/Library/CoreServices/Menu\ Extras/User.menu/Contents/Resources/CGSession -suspend"
alias afk="pmset displaysleepnow"


###################################################################### Wifi
alias wifi="airport -I"
alias wifi.id="airport -I | awk '/ SSID/ {print substr(\$0, index(\$0, \$2))}'"
alias wifi.scan="airport -s"
alias wifi.history="defaults read /Library/Preferences/SystemConfiguration/com.apple.airport.preferences | grep LastConnected -A 7"
alias wifi.on="networksetup -setairportpower en0 on"
alias wifi.off="networksetup -setairportpower en0 off"
alias wifi.dhcp="ipconfig getpacket en0"
alias wifi.dhcp.renew="sudo ipconfig set en0 DHCP"

# Indent the output with colors for the sake of Fashion
function indent_output () {
    local bullet=$(echo -e "$fg[yellow]╴$reset_color")
    local response=$(eval $1 | awk '{$1=$1};1')
    
    echo -e $response | sed "s/^/    $bullet /"
}

###################################################################### macOS info

# Quick info on machine
function mac () {
    strinfo "Version"
    indent_output "sw_vers"
    
    strinfo "Uptime"
    indent_output "uptime"

    strinfo "CPU"
    indent_output "sysctl -n machdep.cpu.brand_string"
    
    strinfo "Hardware"
    indent_output "networksetup -listallhardwareports"
}

alias mac.hide.dock="defaults write com.apple.dock autohide -bool true && killall Dock"
alias mac.show.dock="defaults write com.apple.dock autohide -bool false && killall Dock"
alias mac.show.desktop="defaults write com.apple.finder CreateDesktop -bool true && killall Finder"
alias mac.hide.desktop="defaults write com.apple.finder CreateDesktop -bool false && killall Finder"
alias mac.show.extensions="defaults write -g AppleShowAllExtensions -bool true && killall Finder"
alias mac.hide.extensions="defaults write -g AppleShowAllExtensions -bool false && killall Finder"
alias mac.invisibles="defaults read com.apple.finder AppleShowAllFiles"
alias mac.show.invisibles="defaults write com.apple.finder AppleShowAllFiles true && killall Finder"
alias mac.hide.invisibles="defaults write com.apple.finder AppleShowAllFiles false && killall Finder"
alias mac.enable.diskverify="defaults write com.apple.frameworks.diskimages skip-verify -bool true && defaults write com.apple.frameworks.diskimages skip-verify-locked -bool true && defaults write com.apple.frameworks.diskimages skip-verify-remote -bool true"
alias mac.disable.diskverify="defaults write com.apple.frameworks.diskimages skip-verify -bool false && defaults write com.apple.frameworks.diskimages skip-verify-locked -bool false && defaults write com.apple.frameworks.diskimages skip-verify-remote -bool false"
alias mac.disable.meta="defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true && defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true && killall Finder"
alias mac.enable.meta="defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool false && defaults write com.apple.desktopservices DSDontWriteUSBStores -bool false && killall Finder"

# Copy man file to clipboard without the silly characters
bro () {
    man $1 | col -b | pbcopy
    echo -e "$fg[blue]→$reset_color Manual for $fg[yellow]$(which $1)$reset_color copied"
}

# Reload the shell
reload () {
    # exec $SHELL -l
    strinfo "Reloading..."
    source $HOME/.zshrc && clear
}

# Ask for confirmation
# ex: "if confirm "Hello"; then"
confirm () {
    echo -n "$fg[blue]?$reset_color $1 (y/n)? "
    read answer

    if [ "$answer" != "${answer#[Yy]}" ] ;then
        return 0
    else
        return 1
    fi
}

# Clone a git repo, ask if .git folder should be removed or kept.
clone () {
    local dname=$(echo $1 | grep -o "[^/]*\.git")
    dname=${dname//.git}
    
    if confirm "Remove .git folder"; then
        git clone $1 && cd $dname && rm -rf .git
    else
        git clone $1 && cd $dname
    fi
}

# Where am I?
ip () {
    strinfo "Outgoing"
    indent_output "dig +short myip.opendns.com @resolver1.opendns.com"

    strinfo "Wireless"
    indent_output "ipconfig getifaddr en0"
    
    strinfo "Ethernet"
    indent_output "ipconfig getifaddr en7"
}

# Create a directory and change into it at the same time
mkd () {
    mkdir -p "$@" && cd "$@";
}

# Timestamps
timestamp () {
    echo "console.log((new Date($1)).toDateString())" | node --
    echo "console.log((new Date($1)).toISOString())" | node --
    echo "console.log((new Date($1)).toLocaleString())" | node --
    echo "console.log((new Date($1)).toTimeString())" | node --
    echo "console.log((new Date($1)).toUTCString())" | node --
    echo "console.log((new Date($1)).getTime())" | node --
    echo "console.log(parseInt(((new Date($1)).getTime() / 1000).toFixed(0)))" | node --
}

# Workaround for including contextual bin folder based off current path.
chpwd () {
    if [[ $PWD == $HOME ]]; then
        title " "
    else
        title "$(pwd | sed "s|^$HOME/||" | sed "s|/|/|")"
    fi
    
    clear
    export PATH="$PWD/bin:$PWD/node_modules/.bin:$BASEPATH"
}

# Connect completion
_connect () { _arguments -C "1: :($(connect --complete))" }
compdef _connect connect

# Disconnect completion
_disconnect () { _arguments -C "1: :($(disconnect --complete))" }
compdef _disconnect disconnect

# Removes duplicates from clipboard, then copies back the clean set
dupes () {
    pbpaste | sort -u | pbcopy
    echo -e "$fg[blue]!$reset_color Duplicates removed"
}

# Bad output
strbad () { echo -e "$fg[red]✖$reset_color $1 " }

# Informative output
strinfo () { echo -e "$fg[blue]ℹ$reset_color $1 " }

# Success/good output
strgood () { echo -e "$fg[green]✔$reset_color $1 " }

# Warning output
strwarn () { echo -e "$fg[yellow]!$reset_color $1 " }

# Update brew, npm and composer.
update () {
    strinfo "Updating Homebrew Core"
    brew update > /dev/null
    
    strinfo "Updating Homebrew Formulas"
    brew upgrade --force-bottle > /dev/null
    
    strinfo "Cleaning up Homebrew"
    brew cleanup > /dev/null
    
    strinfo "Updating NPM Packages"
    npm update -g > /dev/null
    
    strinfo "Updating Composer Core"
    composer global self-update --quiet > /dev/null
    
    strinfo "Updating Composer Packages"
    composer global update --quiet > /dev/null
}

# Start the day
morning () {
    clear
    open "/Applications/Microsoft Outlook.app/"
    open "/Applications/Google Chrome.app/"
    open "/Applications/Spotify.app/"
    open "/Applications/Visual Studio Code.app/"
    open "/Applications/Slack.app/"
    open "/Applications/Things3.app/"
    open "/Applications/Bear.app/"
    open "/Applications/Trello.app/"
    clear
    update
}

# WHOIS info, but only the goodies
whois () {
    local domain=$(echo "$1" | awk -F/ '{print $3}') # get domain from URL
    if [ -z $domain ] ; then
        domain=$1
    fi
    echo "Getting record for $fg[blue]$domain$reset_color ..."

    # avoid recursion | this is the best whois server | strip extra fluff
    indent_output "/usr/bin/whois -h whois.internic.net $domain | sed '/NOTICE:/q'"
}

# who is using the laptop's iSight camera?
camerausedby () {
    strinfo "Checking to see who's using the camera..."
    usedby=$(lsof | grep -w "AppleCamera\|USBVDC\|iSight" | awk '{printf $2"\n"}' | xargs ps)
    echo -e "Recent camera uses:\n$usedby"
}

# Have dig display the most useful info
digit () {
    dig +nocmd "$1" any +multiline +noall +answer;
}

# Color-fied man pages
man () {
    env \
    LESS_TERMCAP_mb=$(printf "\e[1;31m") \
    LESS_TERMCAP_md=$(printf "\e[1;31m") \
    LESS_TERMCAP_me=$(printf "\e[0m") \
    LESS_TERMCAP_se=$(printf "\e[0m") \
    LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
    LESS_TERMCAP_ue=$(printf "\e[0m") \
    LESS_TERMCAP_us=$(printf "\e[1;32m") \
    man "$@"
}

# Color-fied cat
cat () {
    local out colored
    out=$(/bin/cat $@)
    colored=$(echo $out | pygmentize -f console -g 2>/dev/null)
    [[ -n $colored ]] && echo "$colored" || echo "$out"
}

cap () {
    fname="screen--$(date +%F--%H-%M-%S).png"
    screencapture "$HOME/caps/$fname"
    echo -e "$fg[blue]⇣$reset_color Saved to ~/caps/$fname"
}

cap-frame () {
    fname="frame--$(date +%F--%H-%M-%S).png"
    screencapture -i "$HOME/caps/$fname"
    echo -e "$fg[blue]⇣$reset_color Saved to ~/caps/$fname"
}

cap-window () {
    fname="window--$(date +%F--%H-%M-%S).png"
    screencapture -i -w "$HOME/caps/$fname"
    echo -e "$fg[blue]⇣$reset_color Saved to ~/caps/$fname"
}

caps () {
    open "$HOME/caps"
}

caps-dump () {
    rm -rf "$HOME/caps/*"
}
