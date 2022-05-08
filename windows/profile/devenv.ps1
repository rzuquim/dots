$env:HOST_IP = (Test-Connection -ComputerName (hostname) -Count 1).IPV4Address.IPAddressToString;

Set-Alias -Name opencover -Value OpenCover.Console.exe

# PowerShell parameter completion shim for the dotnet CLI
Register-ArgumentCompleter -Native -CommandName dotnet -ScriptBlock {
    param($commandName, $wordToComplete, $cursorPosition)
        dotnet complete --position $cursorPosition "$wordToComplete" | ForEach-Object {
           [System.Management.Automation.CompletionResult]::new($_, $_, 'ParameterValue', $_)
        }
}
