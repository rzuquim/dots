
# slow to load, but adds git autocomplete
Import-Module posh-git

function on-gitlab($path = '/-/network/@branch') {
    $ssh = git config --get remote.origin.url
    $branch = git rev-parse --abbrev-ref HEAD
    $path = $path.replace('@branch', $branch)
    $http = 'http://' + $ssh.trim().substring(4, $ssh.length - 8).replace(':', '/') + $path
    write-host "navigating to: $http"
    start-process -FilePath $http
}

function on-github($path = '/tree/@branch') {
    $ssh = git config --get remote.origin.url
    $branch = git rev-parse --abbrev-ref HEAD
    $path = $path.replace('@branch', $branch)
    $http = 'http://' + $ssh.trim().substring(4, $ssh.length - 8).replace(':', '/') + $path
    write-host "navigating to: $http"
    start-process -FilePath $http
}

function git-change-ssh {
    param (
        [Parameter(Mandatory = $true)]
        [string]$target
    )
    $pvtKey = "$env:USERPROFILE\.ssh\id_ed25519"
    $pubKey = "$pvtKey.pub"

    # Checking if private/pub keys are not links (not following the desired convention)
    if (Test-Path -Path $pvtKey) {
        $file = Get-Item $pvtKey
        if (-not ($file.Attributes -band [IO.FileAttributes]::ReparsePoint)) {
          Write-Host "Private key is not a link!"
          return
        }
    }

    if (Test-Path -Path $pubKey) {
        $file = Get-Item $pubKey
        if (-not ($file.Attributes -band [IO.FileAttributes]::ReparsePoint)) {
          Write-Host "Public key is not a link!"
          return
        }
    }

    # Deleting and creating symbolic links to the desired secrets
    if (Test-Path -Path $pvtKey -PathType Leaf) {
        Remove-Item -Path $pvtKey
    }

    if (Test-Path -Path $pubKey -PathType Leaf) {
        Remove-Item -Path $pubKey
    }

    New-Item -ItemType SymbolicLink -Path $pvtKey -Value "$env:USERPROFILE\.ssh\secrets\$target"
    New-Item -ItemType SymbolicLink -Path $pubKey -Value  "$env:USERPROFILE\.ssh\secrets\$target.pub"
}
