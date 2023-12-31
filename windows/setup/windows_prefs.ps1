
# Disable bing search
$RegistryPath = "HKCU:\Software\Policies\Microsoft\Windows\Explorer"
$ValueName = "DisableSearchBoxSuggestions"
if (-Not (Test-Path $RegistryPath)) {
    New-Item -Path $RegistryPath -Force
}
Set-ItemProperty -Path $RegistryPath -Name $ValueName -Value 1

# Disable snipping tool
$RegistryPath = "HKCU:\Control Panel\Keyboard"
$ValueName = "PrintScreenKeyForSnippingEnabled"
if (-Not (Test-Path $RegistryPath)) {
    New-Item -Path $RegistryPath -Force
}
Set-ItemProperty -Path $RegistryPath -Name $ValueName -Value 0

