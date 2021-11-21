oh-my-posh --init --shell pwsh --config C:\Users\arvindh\posh-theme\ar.omp.json | Invoke-Expression
# Set-PoshPrompt -Theme C:\Users\arvindh\posh-theme\ar.omp.json 
Enable-PoshTooltips
Enable-PoshTransientPrompt

Import-Module -Name Terminal-Icons


Import-Module PSReadLine
Set-PSReadLineOption -PredictionSource HistoryAndPlugin
Set-PSReadLineOption -EditMode Windows

## ListView Settings
Set-PSReadLineOption -PredictionViewStyle ListView

# Set-PSReadlineKeyHandler -Key Tab -Function AcceptSuggestion 

### InlineView Setting
# Set-PSReadLineOption -PredictionViewStyle InlineView
# Set-PSReadlineKeyHandler -Key UpArrow -Function HistorySearchBackward
# Set-PSReadlineKeyHandler -Key DownArrow -Function HistorySearchForward


Set-PSReadLineOption -ShowToolTips
