# -------------------------------------------------------------------
# System
# -------------------------------------------------------------------
alias rez='exec zsh'
alias x86='env /usr/bin/arch -x86_64 /bin/zsh --login'
alias arm='env /usr/bin/arch -arm64 /bin/zsh --login'

# -------------------------------------------------------------------
# Kitty Aliases
# -------------------------------------------------------------------
alias d="kitten diff"
alias icat="kitten icat"
alias rg="rg --hyperlink-format=kitty"
alias awrit="cd ~/awrit; ./awrit"
alias gd="git difftool --no-symlinks --dir-diff"

# -------------------------------------------------------------------
# Obsidian Aliases
# -------------------------------------------------------------------
alias notes='cd ~/Documents/Obsidian'

alias m="make"

# -------------------------------------------------------------------
# NPM Aliases
# -------------------------------------------------------------------
alias nr="npm run"
alias ni="npm install"
alias ns="npm start"
alias nu="npm uninstall"

# remove the node_modules folder and the package-lock.json file from the current directory
alias remove-node_modules='rm -rf node_modules; rm package-lock.json'

# -------------------------------------------------------------------
# EZA Commands to replace ls
# -------------------------------------------------------------------
alias ls='eza --all --classify --group-directories-first --icons=always'
alias ll='eza --all --long --header --group-directories-first --icons=always'
alias lf='eza --long --only-files --header --icons=always'
alias ld='eza --long --only-dirs --header --group-directories-first --icons=always'

# -------------------------------------------------------------------
# Bat
# -------------------------------------------------------------------
alias cat='bat'
alias bathelp='bat --plain --language=help'
#alias -g -- -h='-h 2>&1 | bat --language=help --style=plain'
#alias -g -- --help='--help 2>&1 | bat --language=help --style=plain'
alias man='batman'
alias ripgrep='batgrep'

# -------------------------------------------------------------------
# IDEA
# -------------------------------------------------------------------
alias idea='open -na "/Applications/IntelliJ IDEA.app" --args "$@"'
# idea='open -na "/Applications/IntelliJ IDEA.app" --args "$@"'
# alias idea='$idea $(kitten choose-file)'

# -------------------------------------------------------------------
# dotfiles
# -------------------------------------------------------------------
dotfiles='~/dotfiles'
alias dotfiles='cd '$dotfiles''

# -------------------------------------------------------------------
# air (go)
# -------------------------------------------------------------------
alias air='$(go env GOPATH)/bin/air'

# -------------------------------------------------------------------
# git
# -------------------------------------------------------------------
alias gca='git commit -a'
alias core='cd ~/Projects/atoms-core/'
alias s='git switch'
alias sc='git switch -c'
alias grp='git fetch --prune'
alias gsd='git stash && git stash drop'
alias gsc='git stash clear'
alias com='git switch main && git pull'
alias pull='git pull'
alias push='git push'
alias gp='git push -u origin HEAD'

# -------------------------------------------------------------------
# ATOMS
# -------------------------------------------------------------------
alias ac='cd ~/Projects/atoms-core/'
alias aa='cd ~/Projects/atoms-access-service/'
alias au='cd ~/Projects/atoms-user-service/'

