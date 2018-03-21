# Custom settings
#
if [ -f "${HOME}/.bash_custom" ];
then
    source "${HOME}/.bash_custom"
fi

# Aliases
#
# Some people use a different file for aliases
if [ -f "${HOME}/.bash_aliases" ];
then
  source "${HOME}/.bash_aliases"
fi

alias emacs="/Applications/Emacs.app/Contents/MacOS/Emacs -nw"
alias sublime="/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl"
