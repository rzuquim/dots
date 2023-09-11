# oh-my-posh init pwsh --config ~/.rzuquim.omp.json | Invoke-Expression
Invoke-Expression (&starship init powershell)

Set-PSReadlineOption -EditMode vi
Set-PSReadLineOption -ViModeIndicator Prompt
Set-PSReadLineOption -BellStyle None
