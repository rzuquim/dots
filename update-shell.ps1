function confirm($path) {
    if (-not (Test-Path $path)) { return $true }
    $confirm = Read-Host -Prompt "There is already a $path available. Are you sure you want to overwrite it? (y/N)"
    return $confirm.StartsWith('y') -or $confirm.StartsWith('Y')
}

# creates a link to powershell 7 profile
$ps7Profile = "$env:OneDrive\Documentos\PowerShell\Microsoft.PowerShell_profile.ps1"

if (-not (Test-Path $ps7Profile)) {
    $oldPsProfileDir = "$env:OneDrive\Documentos\WindowsPowerShell\"
    $ps7ProfileDir = Split-Path $ps7Profile -Parent
    Write-Host $ps7ProfileDir
    Remove-Item -Recurse -Force $ps7ProfileDir
    New-Item -ItemType SymbolicLink -Path $ps7ProfileDir -Value $oldPsProfileDir
    Write-Host "PS7 Setup"
}

# ##############
# Git
# ##############

if (confirm("~/.gitconfig")) {
  cp .\common\.gitconfig ~/.gitconfig -Force
}

# ##############
# Vim
# ##############

if (confirm("~/.vimrc")) {
  Get-Content .\common\.vimrc, .\common\.ideavimrc | Set-Content ~/.ideavimrc
  cp .\common\.vimrc ~/.vimrc -Force
  rm -Recurse -Force $env:LOCALAPPDATA\nvim
  cp -Recurse .\common\.config\nvim $env:LOCALAPPDATA\nvim
}

# ##############
# Prompt
# ##############
if (confirm("~/.rzuquim.omp.json")) {
  cp ./common/.rzuquim.omp.json ~/.rzuquim.omp.json -Force
}

if (confirm("~/.config/starship.toml")) {
  cp ./common/.config/starship.toml ~/.config/starship.toml -Force
}

# ##############
# Profile
# ##############

if (confirm($PROFILE)) {
  $profileDir = Split-Path $PROFILE
  cp .\windows\profile.ps1 $PROFILE -Force
  rm $profileDir\profile -Recurse -Force
  cp .\windows\profile $profileDir -Recurse -Force
}

& $profile
