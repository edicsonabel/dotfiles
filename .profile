# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
# umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
      . $HOME/.bashrc
    fi
  fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
  PATH="$HOME/bin:$PATH"
fi

if [ -d "$HOME/.local/bin" ] ; then
  PATH=$HOME/.local/bin:$PATH
fi

# YARN
if [ -d "$HOME/.yarn/bin" ] ; then
  PATH=$HOME/.yarn/bin:$PATH
fi

# GO
if [ -d "$HOME/go" ] ; then
  export GOPATH=$HOME/go
  export GOBIN=$GOPATH/bin
  # export GOROOT=/usr/bin/go
  # export GOROOT=/usr/local/go
  PATH=$GOBIN:$PATH
fi

# FNM
if [ -d "$HOME/.local/share/fnm" ] ; then
  PATH="$HOME/.local/share/fnm:$PATH"
  eval "`fnm env`"
fi

# BUN
if [ -s "$HOME/.bun/_bun" ] ; then
  # bun completions
  source "$HOME/.bun/_bun"
  export BUN_INSTALL="$HOME/.bun"
  PATH=$BUN_INSTALL/bin:$PATH
fi



if [ -d "/usr/lib/jvm/jdk1.8.0_231" ] ; then
  PATH="/usr/lib/jvm/jdk1.8.0_231/bin:$PATH"
fi

if [ -d "/opt/mssql" ] ; then
  PATH="/opt/mssql/bin:$PATH"
fi

if [ -d "/opt/mssql-tools" ] ; then
  PATH="/opt/mssql-tools/bin:$PATH"
fi

# iBus
# export GTK_IM_MODULE=ibus
# export XMODIFIERS=@im=ibus
# export QT_IM_MODULE=ibus

# setxkbmap -model pc105 -layout latam
# setxkbmap -model pc105 -layout us -variant intl

# some more ls aliases
alias ls='lsd --group-dirs=first'
alias ll='ls -lF'
alias la='ls -la'
alias l='ls -F'
alias lh='ls -lh'
alias lha='ls -lha'
# NPM
alias na='npm add'
alias ni='npm install'
alias nr='npm remove'
alias ns='npm start'
alias nu='npm up'
alias ninit='npm init'
alias nrun='npm run'
# YARN
alias ya='yarn add'
alias yi='yarn install'
alias yr='yarn remove'
alias yu='yarn up'
alias ys='yarn start'
alias yinit='yarn init'
alias yrun='yarn run'
# PNPM
alias pna='pnpm add'
alias pni='pnpm install'
alias pnr='pnpm remove'
alias pnu='pnpm up'
alias pns='pnpm start'
alias pninit='pnpm init'
alias pnrun='pnpm run'
# BUN
alias ba='bun add'
alias bi='bun install'
alias br='bun remove'
alias bu='bun update'
alias bs='bun start'
alias binit='bun init'
alias brun='bun run'
# Personal
alias ea='/run/media/edicsonabel/EdicsonAbel/'
alias projects='/run/media/edicsonabel/EdicsonAbel/Proyectos/'
alias cat='bat'
alias vim='nvim && rc'
# set default EDITOR and VISUAL (vim or nano)
if [ -z "$(which nvim)" ]; then
  export EDITOR="nano"
else
  export EDITOR="nvim"
fi

export VISUAL="nano"
