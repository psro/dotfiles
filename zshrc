# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000

# Keybindings
bindkey -e
bindkey "^[[1;5D" backward-word
bindkey "^[[1;5C" forward-word

# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall

zstyle ':completion:*' completer _expand _complete _ignored
zstyle ':completion:*' completions 1
zstyle ':completion:*' expand prefix
zstyle ':completion:*' glob 1
zstyle ':completion:*' group-name ''
zstyle ':completion:*' ignore-parents parent pwd
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' menu select=1
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle :compinstall filename '/Users/samuel/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

autoload bashcompinit
bashcompinit

autoload -U colors && colors

# Version
autoload -Uz vcs_info

zstyle ':vcs_info:*' actionformats \
    '%F{5}(%f%s%F{5})%F{3}-%F{5}[%F{2}%b%F{3}|%F{1}%a%F{5}]%f '
zstyle ':vcs_info:*' formats '%r' '%c%u' '%.20b'
zstyle ':vcs_info:(sv[nk]|bzr):*' branchformat '%b%F{1}:%F{3}%r'
zstyle ':vcs_info:*' stagedstr '%F{11}'
zstyle ':vcs_info:*' unstagedstr '%F{11}'
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' max-exports 5
zstyle ':vcs_info:*' get-revision true

function get_git_status() {
    local git_status
    local num_untracked
    local num_staged
    local num_unstaged
    local msg

    msg=""
    git_status=$(git status -s -uno)

    num_staged="$(echo "${git_status}" | egrep -c "^\w")"
    if [[ $num_staged != "0" ]]; then
        msg="${msg}%F{10}${num_staged}±%f "
    fi
    num_unstaged="$(echo "${git_status}" | egrep -c "^ \w")"
    if [[ $num_unstaged != "0" ]]; then
        msg="${msg}%F{9}${num_unstaged}!%f "
    fi
    num_untracked="$(echo "${git_status}" | egrep -c "^\?\?")"
    if [[ $num_untracked != "0" ]]; then
        msg="${msg}%F{11}${num_untracked}?%f "
    fi
    echo $msg
}

function format_vcs_msg() {
    echo "%K{241} %U$1%u @ %U%F{2}$4$2%u $3%f ░%k"
}

function get_vcs_msg() {
    local vcs_status
    vcs_info
    if [[ $vcs_info_msg_0_ != "" ]]; then
        vcs_status=$(get_git_status)
        echo $(format_vcs_msg $vcs_info_msg_0_ $vcs_info_msg_2_ $vcs_status \
            $vcs_info_msg_1_)
    else
        echo ""
    fi
}

function precmd() {
    local prompt_path
    local prompt_line_end
    local prompt_end
    local prompt_vcs_msg

    prompt_path='%K{240}┌ %U%~%u ░%k'
    prompt_line_end=$'%K{242}%E%k\n'
    prompt_end='└ %# '
    prompt_vcs_msg=$(get_vcs_msg)

    if [[ -z ${vcs_dir} ]]; then
        PROMPT="${prompt_path}${prompt_vcs_msg}${prompt_line_end}${prompt_end}"
        RPROMPT="%T"
    else
        PROMPT="${prompt_path}${prompt_line_end}${prompt_end}"
        RPROMPT="%T"
    fi
}

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# Env

PATH="/usr/local/bin:${PATH}"

if [[ -n "$DISPLAY" && "$TERM" == "xterm" ]]; then
   TERM=xterm-256color
fi

## Load SSH Keys if keychain is available.
[[ -f $(which keychain 2> /dev/null) ]] && \
     keychain --nogui --quiet id_rsa


# Editor

export ALTERNATE_EDITOR=emacs EDITOR=emacsclient VISUAL=emacsclient
