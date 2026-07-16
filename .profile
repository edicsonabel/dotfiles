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

# PATH and exported variables live in ~/.env.sh, which is side-effect free so
# that non-interactive shells can read it too (zsh does, via ~/.zshenv).
# Sourcing it twice is harmless — it skips PATH entries already present.
# This file keeps the interactive-only setup: shell hooks, aliases, ssh-agent,
# tmux.
if [ -f "$HOME/.env.sh" ] ; then
  . "$HOME/.env.sh"
fi

# FNM — installs a chdir hook; PATH is set in ~/.env.sh
if command -v fnm >/dev/null 2>&1 ; then
  eval "`fnm env --use-on-cd`"
fi

# BUN completions — BUN_INSTALL and PATH are set in ~/.env.sh
if [ -d "$HOME/.bun" ] ; then
  # if not running bash
  if [ ! -n "$BASH_VERSION" ]; then
    source "$HOME/.bun/_bun"
  fi
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

# zoxide
if command -v zoxide >/dev/null 2>&1; then
  eval "$(zoxide init $CURRENT_SHELL)"
fi

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

# EDITOR and VISUAL are set in ~/.env.sh

# Auto-attach to tmux on interactive terminal (bash + zsh)
# When the server is already up, attach to its most recent session (e.g. one
# restored by tmux-continuum). When it is down (after reboot), create the
# first session: loading tmux.conf triggers continuum-restore in the
# background, which brings back the previous sessions in the same server.
case $- in
  *i*)
    if command -v tmux >/dev/null 2>&1 && [ -t 1 ] && [ -z "$TMUX" ]; then
      if tmux list-sessions >/dev/null 2>&1; then
        tmux attach-session
      else
        tmux new-session
      fi
    fi
    ;;
esac
