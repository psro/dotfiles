# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall

zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
zstyle ':completion:*' completions 1
zstyle ':completion:*' expand prefix
zstyle ':completion:*' glob 1
zstyle ':completion:*' group-name ''
zstyle ':completion:*' ignore-parents parent pwd
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' max-errors 2
zstyle ':completion:*' menu select=1
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' substitute 1
zstyle :compinstall filename '/Users/samuel/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

autoload -U colors && colors
autoload -Uz vcs_info

setopt prompt_subst

zstyle ':vcs_info:*' actionformats \
    '%F{5}(%f%s%F{5})%F{3}-%F{5}[%F{2}%b%F{3}|%F{1}%a%F{5}]%f '
zstyle ':vcs_info:*' formats       \
    '%r @ %F{2}%c%u%b%f'
zstyle ':vcs_info:(sv[nk]|bzr):*' branchformat '%b%F{1}:%F{3}%r'
zstyle ':vcs_info:*' stagedstr '%F{3}'
zstyle ':vcs_info:*' unstagedstr '%F{3}'
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' enable git

precmd() {
    vcs_info
    PROMPT='%K{238} %U%~%u %k%K{239}»%k%K{236} %U${vcs_info_msg_0_}%u %k%K{235}%E
%k%# '
    RPROMPT='%T'
}

# Env

PATH=/usr/local/bin:$PATH

