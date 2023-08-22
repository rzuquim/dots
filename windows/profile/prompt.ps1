# oh-my-posh init pwsh --config ~/.rzuquim.omp.json | Invoke-Expression
Invoke-Expression (&starship init powershell)

Set-PSReadlineOption -EditMode vi
Set-PSReadLineOption -ViModeIndicator Prompt
Set-PSReadLineOption -BellStyle None

function dots {
  cd $env:HOMEPATH/.dots/
}

function inoa {
  . 'D:\dev\inoa\ops\cli\src\bin\Release\net6.0\Inoa.Cli.exe'
}

