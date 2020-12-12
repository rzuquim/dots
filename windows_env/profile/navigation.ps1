Import-Module Jump.Location

Import-Module Get-ChildItemColor
Set-Alias l Get-ChildItemColor -Option AllScope
Set-Alias ls Get-ChildItemColorFormatWide -Option AllScope
Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete

function moveToParent() { Set-Location ..}
function moveToGrandpa() { Set-Location ..\..}
function moveToHome() { Set-Location ~ }
function moveToRoot() { Set-Location / }

function mkd($path) { 
    mkdir $path 
    cd $path
}

function grep($search) { 
    Select-String -Pattern $search
}

function goto($search) { 
    try {
        j $search
    } catch {

    }
    Get-ChildItem -Recurse -Directory -Filter "$search*" | select -First 1 | %{$_.FullName} | cd
}

Set-Alias '..' moveToParent
Set-Alias '..' moveToParent
Set-Alias '...' moveToGrandpa
Set-Alias home moveToHome
Set-Alias root moveToRoot
Set-Alias o ii
