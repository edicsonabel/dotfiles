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
    . "$HOME/.bashrc"
  fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
  PATH="$HOME/bin:$PATH"
fi

if [ -d "$HOME/.local/bin" ] ; then
  PATH="$HOME/.local/bin:$PATH"
fi

# YARN
if [ -d "$HOME/.yarn/bin" ] ; then
  PATH="$HOME/.yarn/bin:$PATH"
fi

# PNPM
if [ -d "$HOME/.local/share/pnpm" ] ; then
  PATH="$HOME/.local/share/pnpm:$PATH"
fi

# GO
if [ -d "$HOME/go" ] ; then
  export GOPATH="$HOME/go"
  export GOBIN="$GOPATH/bin"
  PATH="$GOBIN:$PATH"
fi

# FNM
if [ -d "$HOME/.local/share/fnm" ] ; then
  PATH="$HOME/.local/share/fnm:$PATH"
  eval "`fnm env --use-on-cd`"
fi

# BUN
if [ -d "$HOME/.bun" ] ; then
  # if not running bash
  if [ ! -n "$BASH_VERSION" ]; then
    # bun completions
    source "$HOME/.bun/_bun"
  fi
  export BUN_INSTALL="$HOME/.bun"
  PATH="$BUN_INSTALL/bin:$PATH"
fi

# CONSOLE NINJA
if [ -d "$HOME/.console-ninja" ] ; then
  PATH="$HOME/.console-ninja/.bin:$PATH"
fi

# Microsoft SQL Server
if [ -d "/opt/mssql" ] ; then
  PATH="/opt/mssql/bin:$PATH"
fi

# Microsoft SQL Server Tools
if [ -d "/opt/mssql-tools" ] ; then
  PATH="/opt/mssql-tools/bin:$PATH"
fi

# .NET
if [ -d "$HOME/.dotnet/tools" ] ; then
  PATH="$HOME/.dotnet/tools:$PATH"
fi

# OPENCODE
if [ -d "$HOME/.opencode/bin" ] ; then
  PATH="$HOME/.opencode/bin:$PATH"
fi

# SSH Agent
if [ -z "$SSH_AUTH_SOCK" ]; then
    eval "$(ssh-agent -s)" >/dev/null 2>&1;
    # Add all private keys in ~/.ssh named id_* (skip public keys)
    if command -v ssh-add >/dev/null 2>&1; then
      for f in "$HOME"/.ssh/id_*; do
        [ -e "$f" ] || continue
        case "$f" in
          *.pub) continue ;;
        esac
        if [ -f "$f" ]; then
          ssh-add "$f" 2>/dev/null || true
        fi
      done
    fi
fi

# Set current shell
CURRENT_SHELL="$(echo $SHELL | awk -F'/' '{print $4}')"

# fzf
if command -v fzf >/dev/null 2>&1; then
  eval "$(fzf --$CURRENT_SHELL)"
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
alias vim='nvim'
# set default EDITOR and VISUAL (vim or nano)
if [ -z "$(which nvim)" ]; then
  export EDITOR="nano"
else
  export EDITOR="nvim"
fi

export VISUAL="nano"
