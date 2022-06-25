HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000

# Keybindings
bindkey -e
bindkey '^[[1;5C' emacs-forward-word
bindkey '^[[1;5D' emacs-backward-word

# create a zkbd compatible hash;
# to add other keys to this hash, see: man 5 terminfo
typeset -g -A key

key[Home]="${terminfo[khome]}"
key[End]="${terminfo[kend]}"
key[Insert]="${terminfo[kich1]}"
key[Delete]="${terminfo[kdch1]}"

# setup key accordingly
[[ -n "${key[Home]}"      ]] && bindkey -- "${key[Home]}"       beginning-of-line
[[ -n "${key[End]}"       ]] && bindkey -- "${key[End]}"        end-of-line
[[ -n "${key[Insert]}"    ]] && bindkey -- "${key[Insert]}"     overwrite-mode
[[ -n "${key[Delete]}"    ]] && bindkey -- "${key[Delete]}"     delete-char

# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/pranav/.zshrc'

# Custom
alias sudo='sudo '
alias ls='ls --color=auto'
alias vi="nvim"
alias vim="nvim"
alias pbcopy='xclip -selection clipboard'
alias pbpaste='xclip -selection clipboard -o'
alias rn='ranger'
alias n='nmcli'
alias nu='nmcli c up'
alias prm='/usr/bin/rm -i'
alias rm='dl'
alias fixvol='pactl set-sink-volume 0 +1%'
alias mictest='arecord -vv -f dat /dev/null'
alias teams='teams --disable-seccomp-filter-sandbox'

#(cat ~/.cache/wal/sequences &)
source ~/.zshenv

fpath=( ~/.zfunc ~/scripts/zsh-completions "${fpath[@]}" )
autoload -Uz compinit
for dump in ~/.zcompdump(N.mh+24); do
  compinit -C
done
autoload -U promptinit; promptinit
prompt pure
autoload todo 
#autoload chwal

# Hooks
# 1. rehash
zshcache_time="$(date +%s%N)"
autoload -Uz add-zsh-hook
rehash_precmd() {
  if [[ -a /var/cache/zsh/pacman ]]; then
    local paccache_time="$(date -r /var/cache/zsh/pacman +%s%N)"
    if (( zshcache_time < paccache_time )); then
      rehash
      zshcache_time="$paccache_time"
    fi
  fi
}
add-zsh-hook -Uz precmd rehash_precmd
