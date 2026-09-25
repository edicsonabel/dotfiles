# dotfiles

Configuraciones personales. Los archivos se guardan con **la misma ruta que tienen
bajo `$HOME`**, así que restaurar cualquiera es copiarlo de vuelta tal cual, sin
traducir rutas.

```
.zshrc                          ->  ~/.zshrc
.config/alacritty/alacritty.toml  ->  ~/.config/alacritty/alacritty.toml
```

## Qué hay

| Ruta | Qué es |
|---|---|
| `.zshrc`, `.zshenv`, `.profile`, `.env.sh` | Shell |
| `.gitconfig` | Git (sin los ajustes propios de cada máquina) |
| `.tmux.conf` | tmux |
| `.config/alacritty/` | Terminal |
| `.config/nvim/` | Neovim (LazyVim) |
| `.config/qtile/` | Window manager qtile |
| `.config/herdr/` | herdr: config, statusbar y parche del separador |
| `.config/powershell/` | Perfil de PowerShell y oh-my-posh |
| `.config/environment.d/` | Variables de sesión (carpetas XDG) |
| `.config/dolphinrc`, `.config/kwinrulesrc`, `.config/kscreenlockerrc` | KDE: Dolphin, regla de Rocket League, fondo del bloqueo |
| `.config/wireplumber/` | Audio: sin suspensión, prioridad del micro de auriculares |
| `.local/share/applications/` | `game-focus.desktop`, y los atajos globales `atajo-captura` (`Meta+Shift+S`), `atajo-matar` (`Ctrl+Shift+Q`) y `atajo-fondo-siguiente`/`-anterior` (`Meta+Ctrl+.` / `Meta+Ctrl+,`; la coma va escapada, `\,`, porque en `X-KDE-Shortcuts` separa atajos). Para registrarlos hace falta además un symlink en `~/.local/share/kglobalaccel/` y `kbuildsycoca6 --noincremental` |
| `.config/systemd/user/` | Units de usuario |

Qué se guarda, qué se decidió dejar fuera y cómo restaurar tras una actualización que
rompa: `dland/docs/09-respaldo-de-configuraciones.md`.
