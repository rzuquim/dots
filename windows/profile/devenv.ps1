# TODO: schedule a job to sync this
# env:HOST_IP = (Test-Connection -ComputerName (hostname) -Count 1).IPV4Address.IPAddressToString;

Set-Alias -Name opencover -Value OpenCover.Console.exe

# autocomplete dotnet
Register-ArgumentCompleter -Native -CommandName dotnet -ScriptBlock {
    param($commandName, $wordToComplete, $cursorPosition)
        dotnet complete --position $cursorPosition "$wordToComplete" | ForEach-Object {
           [System.Management.Automation.CompletionResult]::new($_, $_, 'ParameterValue', $_)
        }
}

Import-Module npm-completion
Import-Module DockerCompletion

# AWS
function aws-local {
  aws --endpoint-url=http://localhost:4566 $args
}

# editor
function neo {
  neovide $args
}
