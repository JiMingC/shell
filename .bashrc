# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific aliases and functions
alias cj='cd /mnt/nfsroot/jiming.cai'
alias ll='ls -l --color'
alias ls='ls --color'
alias l='ls'
alias vi='vim'
alias cl='clear;ls'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias gl='git log'
alias gs='git show'
alias gb='git branch -a'
alias gd='git diff'
alias ep='echo $PATH'
alias rm='rm -i'
alias cj='source ~/cj.sh'
alias cm='. ~/shell/cj.sh make'
alias csr='source ~/.bashrc'
alias cc='cd ..'
alias sgit='source /etc/bash_completion.d/git-completion.bash'
alias brc='vi ~/.bashrc'
export TERM=xterm-color
alias grep='grep --color=auto'
#alias ch='source ~/myshell.sh'
LS_COLORS='no=00:fi=00:di=01;33:ln=01;36:pi=40;33:so=01;35:bd=40;33;01:cd=40;33;01:or=01;05;37;41:mi=01;05;37;41:ex=01;32:*.cmd=01;32:*.exe=01;32:*.com=01;32:*.btm=01;32:*.bat=01;32:*.sh=01;32:*.csh=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.bz=01;31:*.tz=01;31:*.rpm=01;31:*.cpio=01;31:*.jpg=01;35:*.gif=01;35:*.bmp=01;35:*.xbm=01;35:*.xpm=01;35:*.png=01;35:*.tif=01;35:'
export LS_COLORS

