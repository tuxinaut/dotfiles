# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

#################################################
# History auf 2000 Befehle erweitern            #
#################################################
export HISTSIZE=2000

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# don't overwrite GNU Midnight Commander's setting of `ignorespace'.
HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
        # We have color support; assume it's compliant with Ecma-48
        # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
        # a case would tend to support setf rather than setaf.)
        color_prompt=yes
    else
        color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls -h --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
#alias ll='ls -l'
#alias la='ls -A'
#alias l='ls -CF'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

#########################################################################################
#                                       Meins                                           #
#########################################################################################

PROMPT='\[\033[01;32m\]\u\[\033[01;34m\]::\[\033[01;31m\]\h \[\033[00;34m\]{ \[\033[01;34m\]\w \[\033[00;34m\]}\[\033[01;32m\]-> \[\033[00m\]'
PS1=${PROMPT}

export EDITOR=vim
HISTTIMEFORMAT="%F %T "

# Benachrichtigungen bei langen Prozessen
if [ -x /usr/bin/notify-send ]; then
  alias alert='notify-send -i gnome-terminal "[$?] $(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/;\s*alert$//'\'')"'
fi

# Less Colors for Man Pages
export LESS_TERMCAP_mb=$'\E[01;31m'       # begin blinking
export LESS_TERMCAP_md=$'\E[01;38;5;74m'  # begin bold
export LESS_TERMCAP_me=$'\E[0m'           # end mode
export LESS_TERMCAP_se=$'\E[0m'           # end standout-mode
export LESS_TERMCAP_so=$'\E[38;5;246m'    # begin standout-mode - info box
export LESS_TERMCAP_ue=$'\E[0m'           # end underline
export LESS_TERMCAP_us=$'\E[04;38;5;146m' # begin underline

# Eine Datei finden (Benutzung: ff datei)
function ff() {
  find . -type f -iname '*'$*'*' -ls;
}

function BACKUP_PROJECT() {
  WORK_PATH='/home/tuxinaut/workspace/'
  FOLDER=""
  OPTION=$1
  if [ -n ${OPTION} ]; then
    if [ ${OPTION} == "du" ]; then
      FOLDER="Du Kasse"
    elif [ ${OPTION} == "ver" ]; then
      FOLDER="Vermoegensschaden"
    elif [ ${OPTION} == "one" ]; then
      FOLDER="FPB_Onlinerechner"
    else
      echo "--->Kein Projekt gefunden<---"
      return 0;
    fi

    cp -r "${WORK_PATH}${FOLDER}" "${WORK_PATH}${FOLDER}_$(date +%d_%m_%Y-%H_%M)"
  fi
}

function strToLower () {
  echo ${1,,}
}

function ssh_mount () {
  sshfs cevo_live-server:/ /media/live-server/;
  sshfs cevo_test-server:/ /media/test-server/;
  echo "#################################"
  echo "#             Done              #"
  echo "#################################"
}

RED="\[\033[0;31m\]"
YELLOW="\[\033[0;33m\]"
GREEN="\[\033[0;32m\]"
BLUE="\[\033[0;34m\]"
LIGHT_RED="\[\033[1;31m\]"
LIGHT_GREEN="\[\033[1;32m\]"
WHITE="\[\033[1;37m\]"
LIGHT_GRAY="\[\033[0;37m\]"
COLOR_NONE="\[\e[0m\]"

function pparse_git_branch {
  git rev-parse --git-dir &> /dev/null
  git_status="$(LANG=en_US git status 2> /dev/null)"
  branch_pattern="^# On branch ([^${IFS}]*)"
  detached_branch_pattern="^#.*while rebasing branch"
  remote_pattern="# Your branch is (.*) of"
  diverge_pattern="# Your branch and (.*) have diverged"

  if [[ ${git_status}} =~ "Changed but not updated" ]]; then
    state="${RED}⚡"
  fi
  # add an else if or two here if you want to get more specific
  if [[ ${git_status} =~ ${remote_pattern} ]]; then
    if [[ ${BASH_REMATCH[1]} == "ahead" ]]; then
      remote="${YELLOW}↑"
    else
      remote="${YELLOW}↓"
    fi
  fi

  if [[ ${git_status} =~ ${diverge_pattern} ]]; then
    remote="${YELLOW}↕"
  fi

  if [[ ${git_status} =~ ${branch_pattern} ]]; then
    branch=${BASH_REMATCH[1]}
  elif [[ ${git_status} =~ ${detached_branch_pattern} ]]; then
    branch="${YELLOW}NO BRANCH"
  fi

  if [[ ${#state} -gt "0" || ${#remote} -gt "0" ]]; then
    s=" "
  fi

  echo " ${branch}${s}${remote}${state}"
}

function prompt_func() {
  git rev-parse --git-dir > /dev/null 2>&1

  if [ $? -eq 0 ]; then
    prompt="${TITLEBAR}${BLUE}[${RED}\W${GREEN}$(pparse_git_branch)${BLUE}]${COLOR_NONE} "
    PS1="${prompt}$ "
  else
    PS1=$PSAVE
  fi
}

export PSAVE=$PS1

PROMPT_COMMAND=prompt_func

[ -s "/home/tuxinaut/.scm_breeze/scm_breeze.sh" ] && source "/home/tuxinaut/.scm_breeze/scm_breeze.sh"

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
