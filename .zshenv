# ~/.zshenv: read by zsh for ALL shells — interactive, non-interactive, scripts.
#
# This is what makes PATH work in shells that never read ~/.zshrc, and so never
# source ~/.profile: editors, tooling, coding agents, `zsh -c '...'`.
#
# ~/.env.sh is side-effect free, which is why it is safe here. Interactive setup
# (aliases, prompt, ssh-agent, tmux) stays in ~/.profile, sourced from ~/.zshrc.
#
# Bash has no equivalent to this file — it reads nothing on non-interactive
# shells. Bash login shells get the same environment via ~/.profile.
if [ -f "$HOME/.env.sh" ] ; then
  . "$HOME/.env.sh"
fi
