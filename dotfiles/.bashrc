# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

HISTCONTROL=ignoreboth

shopt -s checkwinsize

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
    for rc in ~/.bashrc.d/*; do
        if [ -f "$rc" ]; then
            . "$rc"
        fi
    done
fi
unset rc

if [ -f $HOME/.bash_aliases ]; then
    . $HOME/.bash_aliases
fi

if [ -f $HOME/.bash_profile ]; then
    . $HOME/.bash_profile
fi

if ! shopt -oq posix; then
    if [ -f /usr/share/bash-completion/bash_completion ]; then
        . /usr/share/bash-completion/bash_completion
    elif [ -f /etc/bash_completion ]; then
        . /etc/bash_completion
    fi
fi

if [ -d "${HOME}/.rbenv" ]; then
  export PATH=$HOME/.rbenv/bin:$PATH
  eval "$(${HOME}/.rbenv/bin/rbenv init -)"
fi

if [ -d "${HOME}/.nvm" ]; then
  export NVM_DIR="${HOME}/.nvm"
  [ -s "${NVM_DIR}/nvm.sh" ] && \. "${NVM_DIR}/nvm.sh" # this loads nvm
  [ -s "${NVM_DIR}/bash_completion" ] && \. "${NVM_DIR}/bash_completion" # this loads nvm bash_completion
fi

if [ -d "/opt/steamtinkerlaunch" ]; then
  export PATH="/opt/steamtinkerlaunch:$PATH"
fi

if [ "$XDG_CURRENT_DESKTOP" == "GNOME" ]; then
  export GPG_TTY=$(tty)
fi
