$ScriptFile = "$env:HOMEPATH\.dots\windows\setup\bg-random-change.ps1"
$Action = New-ScheduledTaskAction -Execute "powershell.exe" -Argument "-NoProfile -File $ScriptFile"
$Trigger = New-ScheduledTaskTrigger -AtLogOn
$Settings = New-ScheduledTaskSettingsSet
Register-ScheduledTask -TaskName "SetRandomBackground" -Action $Action -Trigger $Trigger -Settings $Settings

