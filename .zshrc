if [ -z "$FASTFETCH_RUN" ]; then
    export FASTFETCH_RUN=1
    fastfetch
fi

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

### End of Zinit's installer chunk

autoload -Uz compinit; compinit

# Add in zsh plugins
zinit ice depth=1; zinit light romkatv/powerlevel10k
zinit light zdharma-continuum/fast-syntax-highlighting
# zinit ice as"program" from"gh-r" pick"zsh-patina-*/zsh-patina" atload'eval "$(zsh-patina activate)"'
# zinit light michel-kraemer/zsh-patina
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab
zinit snippet OMZ::plugins/git/git.plugin.zsh
zinit load zsh-users/zsh-history-substring-search
zinit ice wait atload '_history_substring_search_config'
zinit load agkozak/zsh-z
zinit snippet OMZ::plugins/alias-finder
zinit snippet OMZ::plugins/kitty
zinit snippet OMZ::plugins/mvn
zinit light 22peacemaker/zsh-make-complete
zinit load asdf-vm/asdf


# zstyles
zstyle ':omz:plugins:alias-finder' autoload yes # disabled by default
zstyle ':omz:plugins:alias-finder' longer yes # disabled by default
zstyle ':omz:plugins:alias-finder' exact yes # disabled by default
zstyle ':omz:plugins:alias-finder' cheaper yes # disabled by default

zstyle ':fzf-tab:complete:*:*' fzf-preview '
  if [ -d $realpath ]; then
    eza -1 --color=always --group-directories-first --icons=always $realpath
  else
    bat --color=always --style=numbers --line-range=:500 $realpath
  fi'
# disable sort when completing `git checkout`
zstyle ':completion:*:git-checkout:*' sort false
# set descriptions format to enable group support
# NOTE: don't use escape sequences (like '%F{red}%d%f') here, fzf-tab will ignore them
zstyle ':completion:*:descriptions' format '[%d]'
# set list-colors to enable filename colorizing
# force zsh not to show completion menu, which allows fzf-tab to capture the unambiguous prefix
zstyle ':completion:*' menu no
# preview directory's content with eza when completing cd
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza --tree --level=2 --color=always --icons=always $realpath'
zstyle ':fzf-tab:complete:make:*' fzf-preview 'make help'
zstyle ':fzf-tab:complete:git-checkout:*' fzf-preview 'git diff --color=always HEAD..$word | head -200'
zstyle ':fzf-tab:complete:git-switch:*' fzf-preview 'git log --oneline --graph --decorate --color=always $word | head -200'
zstyle ':fzf-tab:complete:docker:*' fzf-preview 'docker inspect $word'
zstyle ':fzf-tab:complete:docker-rmi:*' fzf-preview 'docker image inspect $word'
zstyle ':fzf-tab:complete:export:*' fzf-preview 'printenv $word'
zstyle ':fzf-tab:complete:mvn:*' fzf-preview 'mvn help:describe -Dcmd=$word'

# When completing Maven artifacts, show groupId/artifactId info
zstyle ':fzf-tab:complete:mvn-dependency:*' fzf-preview '
  grep -A2 "<$word" pom.xml | bat --color=always --style=plain'

# custom fzf flags
# NOTE: fzf-tab does not follow FZF_DEFAULT_OPTS by default
# zstyle ':fzf-tab:*' fzf-flags --color=fg:1,fg+:2 --bind=tab:accept
# To make fzf-tab follow FZF_DEFAULT_OPTS.
# NOTE: This may lead to unexpected behavior since some flags break this plugin. See Aloxaf/fzf-tab#455.
zstyle ':fzf-tab:*' use-fzf-default-opts yes
# switch group using `<` and `>`
zstyle ':fzf-tab:*' switch-group '<' '>'

# History
HISTSIZE=10000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Aliases.zsh
[[ -f ~/.config/zsh/aliases.zsh ]] && source ~/.config/zsh/aliases.zsh
# Functions.zsh
[[ -f ~/.config/zsh/functions.zsh ]] && source ~/.config/zsh/functions.zsh
# blackcape_aliases.zsh
[[ -f ~/.config/zsh/blackcape_aliases.zsh ]] && source ~/.config/zsh/blackcape_aliases.zsh

# Homebrew
export PATH="/opt/homebrew/bin:$PATH"
eval "$(/opt/homebrew/bin/brew shellenv)"

# ASDF
export PATH="${ASDF_DATA_DIR:-$HOME/.asdf}/shims:$PATH"

# awrit 
# export PATH="~/awrit/.bun" #todo broken need to figure out

# poetry
#export PATH="/Users/ianmcbee/.local/bin"

# Java
# . ~/.asdf/plugins/java/set-java-home.zsh

# Maven
export PATH=/Users/ianmcbee/.sdkman/candidates/maven/current/bin:$PATH


# Add scripts to PATH 
export PATH="$HOME/scripts:$PATH"

# fuck command
eval $(thefuck --alias fuck)
zinit snippet OMZ::plugins/thefuck

# fzf settings
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
source <(fzf --zsh)

# grc
[[ -s "/etc/grc.zsh" ]] && source /etc/grc.zsh

bindkey "^[[A" history-substring-search-up
bindkey "^[[B" history-substring-search-down

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
