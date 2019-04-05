# Git
function Get-GitAddAll { & git add -A $args }
Set-Alias -Name ga -Value Get-GitAddAll

function Get-GitStatus { & git status $args }
Set-Alias -Name gs -Value Get-GitStatus

function Get-GitDiffCached { & git diff --cached $args }
Set-Alias -Name gd -Value Get-GitDiffCached

function Get-GitFetch { & git fetch $args }
Set-Alias -Name gf -Value Get-GitFetch
