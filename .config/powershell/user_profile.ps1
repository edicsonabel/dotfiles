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

<# Linux aliases #>
function gitDir { $gitDir=$(which git).Replace('\cmd\git.EXE', '').Replace('\cmd\git.exe', ''); echo "$gitDir\usr\bin" }
function diffGit { & "$(gitDir)\diff.exe" $args}
del alias:diff -Force
Set-Alias diff diffGit
function echoGit { & echo.exe $args} # don't add $(gitDir)
del alias:echo -Force
Set-Alias echo echoGit
function findGit { & "$(gitDir)\find.exe" $args}
# del alias:find -Force
Set-Alias find findGit
function lsGit { & "$(gitDir)\ls.exe" --color $args}
Set-Alias ls lsGit
function l { & "$(gitDir)\ls.exe" --color $args}
function ll { & "$(gitDir)\ls.exe" --color -l $args}
function la { & "$(gitDir)\ls.exe" --color -la $args}
function lh { & "$(gitDir)\ls.exe" --color -lh $args}
function lha { & "$(gitDir)\ls.exe" --color -lha $args}

<# NPM aliases #>
function na { & npm add $args }
function ni { & npm install $args }
function nr { & npm remove $args }
function ns { & npm start $args }
function nu { & npm up $args }
function ninit { & npm init $args }
function nrun { & npm run $args }

<# YARN aliases #>
function ya { & yarn add $args }
function yi { & yarn install $args }
function yr { & yarn remove $args }
function yu { & yarn up $args }
function ys { & yarn start $args }
function yinit { & yarn init $args }
function yrun { & yarn run $args }

<# PNPM aliases #>
function pna { & pnpm add $args }
function pni { & pnpm install $args }
function pnr { & pnpm remove $args }
function pnu { & pnpm up $args }
function pns { & pnpm start $args }
function pninit { & pnpm init $args }
function pnrun { & pnpm run $args }

<# Customized aliases #>
function cleanMemory { 
  [Microsoft.PowerShell.PSConsoleReadLine]::ClearHistory()
  rm (Get-PSReadlineOption).HistorySavePath
}
function htop { & ntop $args}
function .. { & cd ..}
function projects { & cd $($Env:PROJECTS)}
function pwdFn { & Get-Location | Foreach-Object { $_.Path } }
Set-Alias pwd pwdFn
Set-Alias vim nvim
Set-Alias cat bat  
# Set-Alias ls lsd

<# Clear terminal #>
cls
