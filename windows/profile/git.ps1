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

Import-Module 'C:\tools\poshgit\dahlbyk-posh-git-9bda399\src\posh-git.psd1'

# workaround on git gui imcompatibility with oh-my-posh
function review() {
  $job = Start-Job { cd $args[0]; git gui } -ArgumentList $PWD
  Register-ObjectEvent -InputObject $job -EventName StateChanged -Action {
      Unregister-Event $EventSubscriber.SourceIdentifier
      Remove-Job $EventSubscriber.SourceIdentifier
      Remove-Job -Id $EventSubscriber.SourceObject.Id
  } | Out-Null
}
