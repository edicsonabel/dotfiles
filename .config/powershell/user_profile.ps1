<# Prompt #>
Import-Module Terminal-Icons
Import-Module posh-git
# Set-PoshPrompt Paradox

<# PSReadLineOption #>
Set-PSReadLineOption -BellStyle None
# Set-PSReadLineOption -EditMode Emacs
Set-PSReadLineOption -PredictionViewStyle ListView
Set-PSReadLineOption -PredictionSource HistoryAndPlugin

<# PSFzf #>
Import-Module PSFzf
Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+f' -PSReadlineChordReverseHistory 'Ctrl+r'

<# PSReadlineKeyHandler #>
Set-PSReadlineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadlineKeyHandler -Key DownArrow -Function HistorySearchForward
Set-PSReadlineKeyHandler -Key Ctrl+d -Function DeleteCharOrExit

<# Load Config #>
function Get-ScriptDirectory { Split-Path $MyInvocation.ScriptName }
$PROMPT_CONFIG = Join-Path (Get-ScriptDirectory) 'edicsonabel.omp.json'
oh-my-posh --init --shell pwsh --config $PROMPT_CONFIG | Invoke-Expression

<# Plugin #>
. (Join-Path (Get-ScriptDirectory) "plugins\git.plugin.ps1")

<# Alias #>
function cleanMemory { 
  [Microsoft.PowerShell.PSConsoleReadLine]::ClearHistory()
  rm (Get-PSReadlineOption).HistorySavePath
}
function gitDir { $gitDir=$(which git).Replace('\cmd\git.EXE', '').Replace('\cmd\git.exe', ''); echo "$gitDir\usr\bin" }
function lsGit { & ls.exe --color $args}
Set-Alias ls lsGit
function diffGit { & diff.exe $args}
del alias:diff -Force
Set-Alias diff diffGit
function echoGit { & echo.exe $args}
del alias:echo -Force

Set-Alias echo echoGit
function l { & ls $args}
function ll { & ls -l $args}
function la { & ls -la $args}
function lh { & ls -lh $args}
function lha { & ls -lha $args}
function htop { & ntop $args}
function .. { & cd ..}

function projects { & cd $($Env:PROJECTS)}

# NPM
function na { & npm add $args }
function ni { & npm install $args }
function nr { & npm remove $args }
function ns { & npm start $args }
function nu { & npm up $args }
function ninit { & npm init $args }
function nrun { & npm run $args }
# YARN
function ya { & yarn add $args }
function yi { & yarn install $args }
function yr { & yarn remove $args }
function yu { & yarn up $args }
function ys { & yarn start $args }
function yinit { & yarn init $args }
function yrun { & yarn run $args }
# PNPM
function pna { & pnpm add $args }
function pni { & pnpm install $args }
function pnr { & pnpm remove $args }
function pnu { & pnpm up $args }
function pns { & pnpm start $args }
function pninit { & pnpm init $args }
function pnrun { & pnpm run $args }

function pwdFn { & Get-Location | Foreach-Object { $_.Path } }
Set-Alias pwd pwdFn
Set-Alias vim nvim
Set-Alias cat bat  
# Set-Alias ls lsd

# CLEAR TERMINAL
cls
