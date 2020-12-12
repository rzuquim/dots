Import-Module posh-git
Import-Module oh-my-posh

function on-gilab($path = '/-/network/@branch') {
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
