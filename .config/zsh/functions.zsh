
# this command tests your shell load time
timezsh() {
  shell=${1-$SHELL}
  for i in $(seq 1 10); do /usr/bin/time $shell -i -c exit; done
}

# Shows the colormap for p10k
colormap() {
  for i in {0..255}; do print -Pn "%K{$i}  %k%F{$i}${(l:3::0:)i}%f " ${${(M)$((i%6)):#3}:+$'\n'}; done
}

help() {
  "$@" --help 2>&1 | bathelp
}

batdiff() {
  git diff --name-only --relative --diff-filter=d | xargs bat --diff
}

updatep10k() {
  cd ~/.local/share/zinit/plugins/romkatv---powerlevel10k;
  git pull;
  cd ~;
}

clipcmd() {
  "$@" 2>&1 | xclip -selection clipboard
}
