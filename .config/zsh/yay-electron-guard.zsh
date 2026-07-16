# yay-electron-guard: avisa si una instalación va a compilar electronNN desde
# fuente (clona ~30GB de chromium) en vez de usar el prebuilt electronNN-bin.
#
# Un electronNN se compila desde fuente cuando no está instalado, no está en los
# repos oficiales, y solo existe como PKGBUILD en AUR. Si además hay un
# electronNN-bin, el guard ofrece instalar ese primero para satisfacer la dep.

# Imprime, uno por línea, los majors de electron que se compilarían desde fuente.
# Sin argumentos, inspecciona los upgrades pendientes (caso `yay -Syu` pelado).
_yay_electron_source_builds() {
  local -a candidates
  local pkg dep

  if (( $# )); then
    local -a others
    for pkg in "$@"; do
      if [[ $pkg == electron<-> ]]; then
        candidates+=("$pkg")
      else
        others+=("$pkg")
      fi
    done
    # Una sola llamada para todos: `yay -Si` acepta N paquetes y cuesta lo
    # mismo que uno. Con `yay -Qmq` (79 pkgs) la diferencia es 1.5s vs 110s.
    if (( ${#others} )); then
      dep=$(command yay -Si "${others[@]}" 2>/dev/null \
            | grep -iE '^(Depende de|Depends On)' \
            | grep -oE '\belectron[0-9]+\b')
      [[ -n $dep ]] && candidates+=(${(f)dep})
    fi
  else
    candidates=(${(f)"$(command yay -Qu 2>/dev/null \
                        | grep -oE '^electron[0-9]+' | sort -u)"})
  fi

  candidates=(${(u)candidates:#})
  (( ${#candidates} )) || return 0

  for pkg in $candidates; do
    # Ya instalado, o su -bin ya instalado: nada que compilar.
    command pacman -Qq "$pkg" &>/dev/null && continue
    command pacman -Qq "${pkg}-bin" &>/dev/null && continue
    # En repos oficiales: pacman lo baja prebuilt, no hay build.
    command pacman -Si "$pkg" &>/dev/null && continue
    # Solo avisar si existe un prebuilt alternativo en AUR.
    command yay -Si "${pkg}-bin" &>/dev/null && print -r -- "$pkg"
  done
}

_yay_electron_guard() {
  local -a pkgs needs_bin
  local arg noconfirm=0

  # Separar flags de nombres de paquete. --noconfirm nos deja sin prompt.
  for arg in "$@"; do
    case $arg in
      --noconfirm) noconfirm=1 ;;
      -*) ;;
      *) pkgs+=("$arg") ;;
    esac
  done

  needs_bin=(${(f)"$(_yay_electron_source_builds "${pkgs[@]}")"})
  needs_bin=(${needs_bin:#})
  (( ${#needs_bin} )) || return 0

  print -P ""
  print -P "%F{yellow}⚠  Compilaría electron desde fuente:%f ${needs_bin[*]}"
  print -P "   Clona el mirror de chromium (~30GB), horas de build."
  print -P "   Prebuilt disponible: %F{green}${^needs_bin}-bin%f (~100MB)"
  print -P ""

  if (( noconfirm )); then
    # Con --noconfirm no hay prompt posible: abortar es lo seguro.
    print -P "   %F{red}Abortado%f (--noconfirm). Instala primero:"
    print -P "     yay -S ${^needs_bin}-bin"
    print -P ""
    return 1
  fi

  print -n "   Instalar los -bin primero? [S/n] "
  local reply
  read -r reply
  [[ -z $reply || $reply == [SsYy]* ]] || return 0

  command yay -S --needed "${^needs_bin}-bin"
}

yay() {
  # Interceptar solo sincronización/instalación (-S, -Sy, -Syu, --sync).
  # Excluir -Ss (buscar), -Si (info), -Sc/-Scc (limpiar caché).
  if [[ $1 == -S*([^sic]) || $1 == -S || $1 == --sync ]]; then
    _yay_electron_guard "${@:2}" || return 1
  fi
  command yay "$@"
}
