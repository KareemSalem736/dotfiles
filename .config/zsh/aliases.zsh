# Switching to arm64 to x86 quickly
alias x86="$env /usr/bin/arch -x86_64 /bin/zsh ---login"
alias arm="$env /usr/bin/arch -arm64 /bin/zsh ---login"

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
alias ld='eza -lD --header --group-directories-first --icons=always'
alias lf='eza -lF --header --color=always --group-directories-first --icons=always | grep -v /'
alias lh='eza -dl .* --group-directories-first --icons=always'
alias ll='eza -al --header --group-directories-first --icons=always'
alias ls='eza -alF --header --color=always --sort=size --group-directories-first --icons=always | grep -v /'
alias lt='eza -al --header --sort=modified --group-directories-first --icons=always'

alias l='eza --git-ignore --group-directories-first --icons=always $eza_params'
alias llm='eza --all --header --long --sort=modified --group-directories-first --icons=always $eza_params'
alias la='eza -lbhHigUmuSa --group-directories-first --icons=always'
alias lx='eza -lbhHigUmuSa@ --group-directories-first --icons=always'
alias tree='eza --tree $eza_params'

# -------------------------------------------------------------------
# Bat
# -------------------------------------------------------------------
alias cat='bat'
alias bathelp='bat --plain --language=help'
alias -g -- -h='-h 2>&1 | bat --language=help --style=plain'
alias -g -- --help='--help 2>&1 | bat --language=help --style=plain'
alias man='batman'
alias ripgrep='batgrep'
alias rg='batgrep'

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

