
$profileScripts = (Split-Path $PROFILE) + "\profile"

Get-ChildItem ("$profileScripts/*.ps1") | ForEach-Object {
    $profileScript = (Join-Path $profileScripts $_.Name)
    . $profileScript
} | Out-Null
