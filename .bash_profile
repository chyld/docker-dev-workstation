source ~/.bash_aliases

txt0='\[\e[0;30m\]'
txt1='\[\e[0;31m\]'
txt2='\[\e[0;32m\]'
txt3='\[\e[0;33m\]'
txt4='\[\e[0;34m\]'
txt5='\[\e[0;35m\]'
txt6='\[\e[0;36m\]'
txt7='\[\e[0;37m\]'
txtrst='\[\e[0m\]'    # Text Reset

PATH_NODE=/usr/local/node/bin

export SHELL=/bin/bash
export PATH=$PATH_NODE:$PATH
export PS1="$txt2\u$txt3@$txt2\h $txt4\w 🚀 $txtrst "
