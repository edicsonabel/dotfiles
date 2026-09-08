# dotfiles

Configuraciones personales. Los archivos se guardan con **la misma ruta que tienen
bajo `$HOME`**, así que restaurar cualquiera es copiarlo de vuelta tal cual, sin
traducir rutas.

```
.zshrc                          ->  ~/.zshrc
.config/caelestia/shell.json    ->  ~/.config/caelestia/shell.json
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
| `.config/caelestia/` | **Shell Caelestia sobre Plasma**: barra, atajos, clima, overrides por monitor |
| `.config/caelestia-kde/` | Respuestas dadas al instalador del port a KDE |
| `.config/autostart/` | Arranque de sesión (copyq) |
| `.config/systemd/user/` | Units de usuario |

## Caelestia: copia doble, no symlink

Los archivos de `.config/caelestia/` y `.config/caelestia-kde/` existen **dos veces**,
como archivo real en ambos lados: aquí y en `~/.config/`. Es intencional. Este repo
vive en el disco `EdicsonAbel`, que no siempre está montado; un symlink dejaría a
Caelestia arrancando sin configuración justo el día que el disco no monte.

Para mantener las dos copias iguales:

```bash
sync-dotfiles             # revisa las parejas y sincroniza
sync-dotfiles caelestia   # solo ese grupo
sync-dotfiles --check     # informa sin copiar (exit 1 si hay diferencias)
```

Gana el archivo más reciente; si difieren muestra el diff y pide confirmación antes
de sobrescribir. El script vive en el repo `binarys` y es a las configuraciones lo que
`sync-binarys` es a los ejecutables.

El archivo que más importa no es el que parece: `stolen-shortcuts.json` guarda los
atajos que Caelestia le quitó a KDE, con su nombre y combinación original. Es lo que
permite devolver el escritorio a su estado anterior al desinstalar.

Qué se guarda, qué se decidió dejar fuera y cómo restaurar tras una actualización que
rompa: `dland/docs/09-respaldo-de-configuraciones.md`.
