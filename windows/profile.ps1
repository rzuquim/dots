
$profileScripts = (Split-Path $PROFILE) + "\profile"

Get-ChildItem ("$profileScripts/*.ps1") | ForEach-Object {
    $profileScript = (Join-Path $profileScripts $_.Name)
    $elapsed = (Measure-Command {
        . $profileScript 
    }).TotalMilliseconds
    Write-Host $_.Name " loaded in " $elapsed "ms"
} | Out-Null

