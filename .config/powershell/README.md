## Installation of basic programs (CMD)
```ps
# Brave
winget install -e --id Brave.Brave

# 7-Zip
winget install -e --id 7zip.7zip

# Git
winget install -e --id Git.Git

# PowerShell
winget install -e --id Microsoft.PowerShell

# Visual Studio Code
winget install Microsoft.VisualStudioCode --override "/SILENT /mergetasks=!runcode,addcontextmenufiles,addcontextmenufolders"

# RevoUninstaller
winget install -e --id RevoUninstaller.RevoUninstaller

# GIMP
winget install -e --id GIMP.GIMP

# VLC
winget install -e --id VideoLAN.VLC
```

## Add GIT programs to PATH
We open the environment variables UI with the command `rundll32 sysdm.cpl,EditEnvironmentVariables` to add the Git programs
```
# Path's to add
C:\Program Files\Git\usr\bin
```

## Install Nerd Fonts
We go to [Nerd Fonts](https://github.com/ryanoasis/nerd-fonts), open the release of fonts and only download the one that says `Hack.zip`

## PowerShell config
We open the windows terminal settings and look for the option **Open JSON file** and add the following settings
```json
{
  "alwaysOnTop": false,
  "alwaysShowNotificationIcon": false,
  "copyOnSelect": true,
  "launchMode": "maximized",
  "tabSwitcherMode": "mru",
  "useAcrylicInTabRow": true,
  "profiles": {
    "defaults": {
      "bellStyle": "audible",
      "colorScheme": "Edicson Abel",
      "cursorShape": "underscore",
      "experimental.retroTerminalEffect": false,
      "font": {
        "face": "Hack NF",
        "size": 10
      },
      "opacity": 85,
      "padding": "6",
      "suppressApplicationTitle": false,
      "useAcrylic": true
    },
    {
      "commandline": "pwsh.exe -nologo",
      "name": "PowerShell",
    }
  },
  "schemes": [
    {
      "background": "#0D1926",
      "black": "#363636",
      "blue": "#0883FF",
      "brightBlack": "#424242",
      "brightBlue": "#1E8EFF",
      "brightCyan": "#1EFF8E",
      "brightGreen": "#8EFF1E",
      "brightPurple": "#8E1EFF",
      "brightRed": "#FF1E8E",
      "brightWhite": "#C2C2C2",
      "brightYellow": "#FF8E1E",
      "cursorColor": "#FFFFFF",
      "cyan": "#08FF83",
      "foreground": "#B4E1FD",
      "green": "#83FF08",
      "name": "Edicson Abel",
      "purple": "#8308FF",
      "red": "#FF0883",
      "selectionBackground": "#B4E1FD",
      "white": "#B6B6B6",
      "yellow": "#FF8308"
    },
  ]
}
```

## Custom installation (PowerShell)
```ps
# Scoop
irm get.scoop.sh | iex

# Installation of external programs
scoop install nvm sudo bat lsd neovim fzf which ntop

# Oh My Posh
winget install -e --id JanDeDobbeleer.OhMyPosh

# posh-git
Install-Module -Name posh-git -Scope CurrentUser -Force

# Terminal-Icons
Install-Module -Name Terminal-Icons -Repository PSGallery -Force

# PSReadLine
Install-Module -Name PSReadLine -AllowPrerelease -Scope CurrentUser -Force -SkipPublisherCheck

# PSFzf
Install-Module -Name PSFzf -Scope CurrentUser -Force

# Z
sudo Install-Module -Name z -Force

# Go to the user's home folder
cd

# We clone the dotfiles
git clone https://github.com/edicsonabel/dotfiles.git

# Copy `.gitconfig` to home
cp .\dotfiles\.gitconfig

# Set custom startup in PowerShell
echo '. $env:USERPROFILE\dotfiles\.config\powershell\user_profile.ps1' > $PROFILE.CurrentUserCurrentHost
```