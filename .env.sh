# ~/.env.sh: environment only — PATH and exported variables.
#
# Sourced by every shell, including non-interactive ones that read neither
# ~/.zshrc nor ~/.profile (scripts, editors, tooling, agents):
#   - zsh:  via ~/.zshenv, which zsh reads for ALL shells
#   - bash: via ~/.profile on login shells
#
# Because of that, this file MUST stay side-effect free and idempotent:
# no eval, no subprocess spawning, no aliases, no shell hooks, no output.
# Anything interactive belongs in ~/.profile instead.
#
# POSIX sh only — no bashisms, no zsh-isms.

# Prepend a directory to PATH, skipping it if absent or already present.
# Keeps PATH clean when this file is sourced more than once per shell
# (e.g. zsh reads ~/.zshenv, then ~/.zshrc sources ~/.profile).
_prepend_path() {
  [ -d "$1" ] || return 0
  case ":$PATH:" in
    *":$1:"*) return 0 ;;
  esac
  PATH="$1:$PATH"
}

_prepend_path "$HOME/bin"
_prepend_path "$HOME/.local/bin"

# YARN
_prepend_path "$HOME/.yarn/bin"

# PNPM
_prepend_path "$HOME/.local/share/pnpm"

# GO
if [ -d "$HOME/go" ] ; then
  export GOPATH="$HOME/go"
  export GOBIN="$GOPATH/bin"
  _prepend_path "$GOBIN"
fi

# FNM — PATH only; `fnm env --use-on-cd` installs a chdir hook and lives in
# ~/.profile, since it is an interactive-only side effect.
_prepend_path "$HOME/.local/share/fnm"

# BUN
if [ -d "$HOME/.bun" ] ; then
  export BUN_INSTALL="$HOME/.bun"
  _prepend_path "$BUN_INSTALL/bin"
fi

# CONSOLE NINJA
_prepend_path "$HOME/.console-ninja/.bin"

# Microsoft SQL Server
_prepend_path "/opt/mssql/bin"

# Microsoft SQL Server Tools
_prepend_path "/opt/mssql-tools/bin"

# .NET
if [ -d "$HOME/.dotnet" ] ; then
  export DOTNET_ROOT="$HOME/.dotnet"
  _prepend_path "$HOME/.dotnet"
fi

# OPENCODE
_prepend_path "$HOME/.opencode/bin"

# Rust / Cargo
_prepend_path "$HOME/.cargo/bin"

export PATH

unset -f _prepend_path

# iBus / fcitx5 disabled — using Cinnamon native layout switch
unset GTK_IM_MODULE
unset XMODIFIERS
unset QT_IM_MODULE
unset QT_IM_MODULES

# set default EDITOR and VISUAL (vim or nano)
if command -v nvim >/dev/null 2>&1; then
  export EDITOR="nvim"
else
  export EDITOR="nano"
fi

export VISUAL="nano"
