########################################
#               General                #
########################################
# environments
#
export LC_ALL="en_US.UTF-8"
export LANG="ja_JP.UTF-8"
export PATH=/usr/local/bin:/usr/bin:$PATH

# aliases
#
alias v='vim'
alias ls="ls -FGbv"
alias ll="ls -l"
alias la="ls -a"
# firefox
alias addon-sdk="cd /opt/addon-sdk && source bin/activate; cd -"

# auto change directory
#
setopt auto_cd

# url escape
#
autoload -Uz url-quote-magic
zle -N self-insert url-quote-magic

# use #, ~, ^ as regexp in filename
#
setopt extended_glob

# correct spell miss
#
setopt correct

# comp
#
autoload -Uz compinit
compinit
setopt hist_ignore_dups
HISTFILE=~/.histfile
HISTSIZE=1000000
SAVEHIST=1000000
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey -e
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

########################################
#              OS Settings             #
########################################
case ${OSTYPE} in
  darwin*)
    fpath=($(brew --prefix)/share/zsh/site-functions $fpath)
    trash(){
    mv $1 $HOME/.Trash/;
   }
      ;;
  linux*)
    trash(){
      mv $1 $HOME/.local/share/Trash/files/;
    }
    # keyboard setting
    stty icrnl
    setxkbmap -model jp106 -layout jp
      ;;
esac

########################################
#           Software Settings          #
########################################
# rbenv
#
case ${OSTYPE} in
  darwin*)
    export PATH=$HOME/.rbenv/bin:$PATH
    ;;
  linux*)
    export PATH=$HOME/.rbenv/bin:$PATH
    ;;
  *)
esac
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
source $HOME/.rbenv/completions/rbenv.zsh

# pyenv
#
export PATH=$HOME/.pyenv/shims:$PATH
export PYENV_ROOT=$HOME/.pyenv
export PATH=$PYENV_ROOT/bin:$PATH
if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi

# mecab
#
export MECAB_PATH=/usr/lib/libmecab.so.2

# golang
# 
export GOPATH=$HOME/.go
export PATH=$GOPATH/bin:$PATH

########################################
#               Display                #
########################################
# about ls command
#
export LSCOLORS=gxfxcxdxbxhggdabagacad
zstyle ':completion:*' list-colors 'di=36' 'ln=35' 'ex=31' 'bd=37;46' 'cd=36;43'

# prompt
#
local CYAN=$'%{\e[1;36m%}'
local YELLOW=$'%{\e[1;33m%}'
local DEFAULT=$'%{\e[1;32m%}'

autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' unstagedstr '%F{yellow}改'
precmd() {
  local format_string='%F{white}%b'$DEFAULT':'

  if [[ -n $(git ls-files --modified 2> /dev/null) ]] {
    format_string+=' %u'
  }

  if [[ -n $(git ls-files --other --exclude-standard 2> /dev/null) ]] {
    format_string+='%F{red}未'
  }
  format_string+=' '

  zstyle ':vcs_info:git*' formats $format_string
  vcs_info
}

setopt prompt_subst

PROMPT='%n'$YELLOW'@%M:'$CYAN'%~%$
${vcs_info_msg_0_}'$DEFAULT'$ '
PROMPT2="%_%% "
