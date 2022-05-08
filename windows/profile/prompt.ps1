oh-my-posh init pwsh --config ~/.rzuquim.omp.json | Invoke-Expression

Set-PSReadlineOption -EditMode vi
Set-PSReadLineOption -ViModeIndicator Prompt
Set-PSReadLineOption -BellStyle None

cd $env:TERMINAL_HOME
